package YTCore.Utils
{
	import com.flashSpider.Graphics.Drawing;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	

	public class SegmentManager
	{
		private var segmentCount:int=5;
		public function SegmentManager()
		{
			
		}
		
		
		public static function paintCircle(maxZoom:Number,colors:Array,maxSegment:int,circle_r:Number,subImF:int=6,subImBufferLen:Number=4,alphaPadding:Number=4):Array{
			
			var spr:flash.display.Sprite = new flash.display.Sprite;
			spr.graphics.clear();
			
			
			var current_segment:Number = 0;
			
			// start new segment
			spr.graphics.beginFill(colors[0]);
			spr.graphics.moveTo(circle_r*maxZoom, circle_r*maxZoom);			
			spr.graphics.lineStyle(0,0x000000,0);
			var j:Number=0;
			while(j<=360)
			{
				spr.graphics.lineTo(circle_r*maxZoom+circle_r*maxZoom*Math.cos(j*Math.PI/180), circle_r*maxZoom-circle_r*maxZoom*Math.sin(j*Math.PI/180) );
				
				if(j==((current_segment+1)*(360/maxSegment))){ 
					current_segment++;
					// end segment
					spr.graphics.lineTo(circle_r*maxZoom, circle_r*maxZoom);
					spr.graphics.endFill();
					
					/*
					//line divided two segments
					spr.graphics.lineStyle(2,0x000000,0.5);
					spr.graphics.moveTo(circle_r, circle_r);
					spr.graphics.lineTo(circle_r+circle_r*Math.cos(j*Math.PI/180), circle_r-circle_r*Math.sin(j*Math.PI/180) );
					*/
					
					// start new segment
					spr.graphics.lineStyle(0,0x000000,0);
					spr.graphics.beginFill(colors[current_segment%colors.length]);
					
					
					spr.graphics.moveTo(circle_r*maxZoom, circle_r*maxZoom);
					spr.graphics.lineTo(circle_r*maxZoom+circle_r*maxZoom*Math.cos(j*Math.PI/180), circle_r*maxZoom-circle_r*maxZoom*Math.sin(j*Math.PI/180) );
					
				}
				j+=2;
				if(j>((current_segment+1)*(360/maxSegment)))
				{
					j=((current_segment+1)*(360/maxSegment));	
				}
			}
			
			
			
			
			var mtx:Matrix = new Matrix;
			mtx.createGradientBox(circle_r*maxZoom*2, circle_r*maxZoom*2, 0, 0, 0);
			
			spr.graphics.beginGradientFill(GradientType.RADIAL, [0xffffff, 0xffffff], [1, 0.1], [10, 255], mtx, SpreadMethod.PAD);
			spr.graphics.drawCircle(circle_r*maxZoom, circle_r*maxZoom, circle_r*maxZoom);
			spr.graphics.endFill();
			
			
			
			var bmDArr:Array=[];
			var splitCellSize:int=subImF;
			var samplerSpr:flash.display.Sprite=new flash.display.Sprite();
			samplerSpr.addChild(spr);
			var cellSize:Number=(circle_r*maxZoom*2/splitCellSize);
			for(var m:int=0; m<splitCellSize; m++)
			{
				for(var n:int=0; n<splitCellSize; n++)
				{
					spr.x=-n*(cellSize)+subImBufferLen;
					spr.y=-m*(cellSize)+subImBufferLen;
					
					var bmdx:BitmapData=new BitmapData(cellSize+subImBufferLen,cellSize+subImBufferLen,true,0);
					bmdx.draw(samplerSpr);
					bmDArr.push(getAlphaPaddedBMD(bmdx,alphaPadding));
				}
			}
			
			
			return bmDArr;
		}
		
		private static function getAlphaPaddedBMD(bmd:BitmapData,padding:Number=1):BitmapData
		{
			var fSpr:flash.display.Sprite=new flash.display.Sprite();
			var im:Bitmap=new Bitmap(bmd);
			Drawing.drawRectangle(fSpr,im.height+2*padding,im.width+2*padding,0,0,true,0,0,0,0,0);
			fSpr.addChild(im);
			im.x=im.y=padding;
			
			var finbmd:BitmapData=new BitmapData(fSpr.width,fSpr.height,true,0);
			finbmd.draw(fSpr);
			
			return finbmd;
		}
		
		
		public static function getSegmentBitmapData(segmentCount:int,radius:Number,colArr:Array):Array
		{
			var retArr:Array=[];
			var arr:Array=getSegments(segmentCount,radius,colArr);
			for each(var spr:flash.display.Sprite in arr)
			{
				var bmd:BitmapData = new BitmapData(radius*2, radius*2, true, 0);
				bmd.draw(spr);
				retArr.push(bmd);
			}
			return retArr;
		}
		
		private static function getSegments(segmentCount:int,radius:Number,colArr:Array):Array
		{
			var segmentAng:Number=360/segmentCount;
			var holder:Array=[];
			
			for(var d:int=0; d<segmentCount; d++)
			{
				holder.push(drawSegment(colArr[d%colArr.length],segmentAng,radius));
			}
			
			return holder;
		}
		
		public static function getSingleSegment(segmentIndex:int,sampleColArr:Array,radius:Number,totalSegment:int):BitmapData
		{
			var segmentAng:Number=360/totalSegment;
			var segmentSpr:flash.display.Sprite=drawSegment(sampleColArr[segmentIndex%sampleColArr.length],segmentAng,radius);
			var bmd:BitmapData=new BitmapData(radius*2,radius*2,true,0);
			bmd.draw(segmentSpr);
			
			return bmd;
		}
		
		public static function getSegmentIndex(maxSegment:int, pt:Point, adjustment:Point):int
		{
			return (Math.floor(maxSegment*getAngle(new Point(pt.x-adjustment.x,adjustment.y-pt.y))/360));
		}
		
		private static function getAbsAngle(pt:Point):Number
		{
			return((180/Math.PI)*Math.atan(Math.abs(pt.y)/Math.abs(pt.x)));
		}
		
		private static function getAngle(pt:Point):Number
		{			
			if(pt.x==0)
			{
				if(pt.y>0)
					return 90;
				else 
					return 270;
			}else
			{
				if(pt.x<0)
				{
					if(pt.y<0)
					{
						//x<0, y<0
						return (180+getAbsAngle(pt));
					}else
					{
						//x<0, y>=0
						return (180-getAbsAngle(pt));
					}
				}
				else
				{
					if(pt.y<0)
					{
						//x>0, y<0
						return (360-getAbsAngle(pt));
					}else
					{
						//x>0, y>=0
						return (getAbsAngle(pt));
					}
				}
			}
			
			return null;
		}
		
		
		public static function gSpr(col:uint,segmentAng:Number,segmentRadius:Number=200):flash.display.Sprite
		{
			var spr:flash.display.Sprite=new flash.display.Sprite();
			spr.graphics.clear();
			spr.graphics.lineStyle(0,0x000000,0);
			spr.graphics.moveTo(segmentRadius,segmentRadius);
			spr.graphics.beginFill(col); 
			spr.graphics.lineTo(2*segmentRadius,segmentRadius);
			
			var d:Number=0;
			while(d<segmentAng)
			{
				spr.graphics.lineTo(segmentRadius+segmentRadius*Math.cos(d*Math.PI/180),segmentRadius-segmentRadius*Math.sin(d*Math.PI/180));
				d+=.1;
			}
			if(d>segmentAng)
			{
				spr.graphics.lineTo(segmentRadius+segmentRadius*Math.cos(segmentAng*Math.PI/180),segmentRadius-segmentRadius*Math.sin(segmentAng*Math.PI/180));
			}
			spr.graphics.lineTo(segmentRadius,segmentRadius); 
			spr.graphics.endFill();
			return spr;
		}
		
		
		public static function createSegmentTexture(col:uint,segmentAng:Number,segmentRadius:Number):flash.display.Sprite
		{
			var hingeSpr:flash.display.Sprite=new flash.display.Sprite();
			var textureSpr:flash.display.Sprite=new flash.display.Sprite();
			var maskSpr:flash.display.Sprite=gSpr(0xFF0000,segmentAng,segmentRadius);
			var holderSpr:flash.display.Sprite=new flash.display.Sprite();
			drawLineTexture(textureSpr,maskSpr.width*2,0x000000,3,.15,8);
			holderSpr.addChild(hingeSpr);
			holderSpr.addChild(maskSpr);
			
			
			hingeSpr.addChild(textureSpr);
			textureSpr.x=-segmentRadius;
			textureSpr.y=-segmentRadius;
			
			hingeSpr.x=3*segmentRadius/2;
		    hingeSpr.y=maskSpr.height/2;
			
			hingeSpr.scaleX=-1;
			
			trace(textureSpr.width,textureSpr.height);
			trace(maskSpr.width,maskSpr.height);
			
			
			hingeSpr.mask=maskSpr;
			
			//hingeSpr.rotation=45-Roulette.segmentLineAngle;
			
			return holderSpr;
		}
		
		private static function drawLineTexture(target:flash.display.Sprite,targetWid:Number,lineCol:uint=0xFFFFFF,lineWid:Number=1,lineAlpha:Number=.5,gap:Number=2):void
		{
			var endPts:Array=getLineEndPoints(targetWid,gap);
			var xArr:Array=endPts[0];
			var yArr:Array=endPts[1];
			
			var arrLen:int=xArr.length;
			
			for(var d:int=0; d<arrLen; d++)
			{
				Drawing.drawLine(target,xArr[d].x,xArr[d].y,yArr[d].x,yArr[d].y,lineCol,lineAlpha,lineWid);
			}
			
		}
		
		private static function getLineEndPoints(boxWid:Number,gap:Number=2):Array
		{
			var xArr:Array=[];
			var yArr:Array=[];
			var totalCount:int=Math.ceil(boxWid/gap);
			
			gap=boxWid/totalCount;
			
			for(var d:int=0; d<totalCount-1; d++)
			{
				xArr.push(new Point(boxWid-(d+1)*gap,0));
				yArr.push(new Point(boxWid,(d+1)*gap));
			}
			
			for(d=0; d<totalCount; d++)
			{
				xArr.push(new Point(0,boxWid-(d+1)*gap));
				
				yArr.push(new Point((d+1)*gap,boxWid));;
			}
			
			return [xArr,yArr];
		}
		
		
		public static function drawSegment(col:uint,segmentAng:Number,segmentRadius:Number=200):flash.display.Sprite
		{
			
			var spr:flash.display.Sprite=gSpr(col,segmentAng,segmentRadius);
			
			
			
			var gradSpr:flash.display.Sprite=new flash.display.Sprite();
			var mtx:Matrix = new Matrix;
			mtx.createGradientBox(segmentRadius*2, segmentRadius*2, 0, 0, 0);
			
			gradSpr.graphics.beginGradientFill(GradientType.RADIAL, [0xffffff, 0xffffff], [1, 0], [10, 255], mtx, SpreadMethod.PAD);
			gradSpr.graphics.drawCircle(segmentRadius, segmentRadius, segmentRadius);
			gradSpr.graphics.endFill();
			
			var textureSpr:flash.display.Sprite=createSegmentTexture(col,segmentAng,segmentRadius);
			spr.addChild(gradSpr);
			spr.addChild(textureSpr);
			
			return spr;
		}
	}
}


  