
package YTCore.Components  {
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.UniformGrowth;
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import com.flashSpider.Math.Geometry.SimpleGeometry;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DLine extends Sprite implements IRenderable
	{

	  private var penL:Sprite;
	  private var canDeconnectTail:Boolean = false;
	  private var canDeconnectHead:Boolean = false;
	  private var currentHeadPosition:int = 0;
	  private var currentTailPosition:int = 0;
	  private var segmentArr:Array = [];
      private var pointList:Array=[];
	  private var m:Number;
	  private var c:Number;
	  private var M:Number;
	  private var C:Number;
	  private var lineCol:uint;
	  private var lineWid:Number;
	  private var currentAlpha:Number;
	  private var widIncrement:Number = 0;
	  private var alphaIncrement:Number = 0;
	  private var lastLineCols:Array = [0x000000, 0xFFFFFF]; 
	  private var lastColIndex:int = 1;
	  private var segmentPerFrame:Number ;
	  private var dotted:Boolean = false;
	  private var bTime:Number;
	  
	 
	  
	  private var ugArr:Array = [];
	  
	  
	  private var canDoStep:Boolean = false;
	  private var mdoBleed:Boolean = false;
	  
	  private var textureSpr:Sprite = new Sprite();
	  private var holderSpr:Sprite = new Sprite();
	  
	  private var segmentSprites:Array = [];
	  private var numWipePerFrame:int = 1;
	  private var wtim:Number;
	  
	  
	  private var count:int=1;
         /**
          * 
          * @param	from Beginning point
          * @param	to End point
          * @param	col Colour of the line
          * @param	time time in second to complete the line
          * @param	lWid width of the line at beginning
		  * @param  lwidEnd width of the line at the ending
          * @param	isDotted If the line is dotted
          */
		public function DLine(from:Point,to:Point,col:uint,time:Number=5,lWid:Number=1,lwidEnd:Number=-1,doBleed:Boolean=false,bt:Number=1,initAlpha:Number=1,endAlpha:Number=1,isDotted:Boolean=false,wipeT:Number=1,texture:Sprite=null,p:Sprite=null) {
			// constructor code
			
			mdoBleed = doBleed;
			bTime = bt;
			wtim = wipeT;
			
			penL = p;
			
			
			addChild(textureSpr);
			addChild(holderSpr);
			
			if (texture)
			{
			textureSpr.addChild(texture);
			textureSpr.mask = holderSpr;
			}
			
			drawLine(from, to, col, time, lWid,lwidEnd, isDotted,initAlpha,endAlpha);
			
			wipeTime = wtim;
		}
		
		
		public function set pen(p:Sprite):void
		{
			trace("Pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp",p);
			if (p == null)
			{
				if (penL)
				{
				  try
				  {
					removeChild(penL);  
				  }catch (e:Error)
				  {
				  }
				}
				
				return;
			}
			penL = p;
			addChild(penL);
		}
		
		public function movePen(pt:Point):void
		{
			if (!penL)
			return;
			
			pt=SimpleGeometry.getTransformedCoordinate(pt, this, penL.parent);
			
			
			penL.x = pt.x;
			penL.y = pt.y;
		}
		
		
		public function get segmentCount():int
		{
			return pointList.length - 1;
		}
		
		public function wipeFromTail():void
		{
			canDeconnectTail = true;
		}
		
		public function set wipeTime(wt:Number):void
		{
			var totalFrame:int = int(wt * Global.FRAME_RATE); 
			numWipePerFrame = Math.ceil(pointList.length / totalFrame); 
		}
		
		public function wipeFromHead():void
		{
			canDeconnectHead = true;
		}
		
		public function drawLine(from:Point,to:Point,col:uint,speed:Number=5, lWid:Number=1,lwidEnd:Number=-1,isDotted:Boolean=false,initA:Number=1,endA:Number=1):void
		{
			dotted = isDotted;
			determineLineParameters(from,to,col,speed,lWid,lwidEnd,initA,endA);
			
		}
		
		public function drawLineBetween(ob1:Sprite,ob2:Sprite,col:uint,offsetx1:Number=0,offsety1:Number=0,offsetx2:Number=0,offsety2:Number=0,speed:Number=5):void
		{
			var pt1:Point=this.globalToLocal(ob1.parent.localToGlobal(new Point(ob1.x+offsetx1,ob1.y+offsety1)));
			var pt2:Point=this.globalToLocal(ob2.parent.localToGlobal(new Point(ob2.x+offsetx2,ob2.y+offsety2)));
			
			drawLine(pt1,pt2,col,speed,lineWid);
			
		}
		
		public function start():void
		{
			canDoStep = true;
		}
		
		public function stop():void
		{
			canDoStep = false;
		}
		
		
		public function step():void
		{
			
			updateWidth();
			
			deconnect();
			
			if (!canDoStep)
			return;
			
			for (var d:int = 1; d <= MathHandler.getNearestInteger(segmentPerFrame); d++ )
			{
				try{
		  connect(pointList[count - 1], pointList[count], lineWid + (count - 1) * widIncrement, currentAlpha + alphaIncrement * count);
		  
		  count += dotted?2:1;
				}
		  catch(e:Error){}
			}
		   if(count>=pointList.length)
		  {
	          canDoStep = false;
			  this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
		  }
		}
		
		private function lineLength(pt1:Point,pt2:Point):Number
		{
			return Math.sqrt((pt1.x-pt2.x)*(pt1.x-pt2.x)+(pt1.y-pt2.y)*(pt1.y-pt2.y));
		}
		
		
		private function deconnectHead():void
		{
			if (!canDeconnectTail)
			return;
			if (currentTailPosition+currentHeadPosition >= segmentArr.length)
			{
				canDoStep = false;
				canDeconnectHead = false;
				return;
			}
			
			segmentArr[segmentArr.length - 1 - currentTailPosition].visible = false;
			
			currentTailPosition++;
		}
		
		private function deconnectTail():void
		{
			if (!canDeconnectHead) 
			return;
			if (currentTailPosition+currentHeadPosition >= segmentArr.length)
			{
				canDoStep = false;
				canDeconnectTail = false;
				return;
			}
			
			
			segmentArr[currentHeadPosition].visible = false;
			
			currentHeadPosition++;
		}
		
		
		private function deconnect():void
		{
			for (var d:int = 0; d < numWipePerFrame; d++ )
			{
				deconnectTail();
				deconnectHead();
			}
		}
		
		private function connect(p1:Point,p2:Point,lWid:Number,alp:Number):void
		{
			
			
			var spr:Sprite = new Sprite();
			holderSpr.addChild(spr);
			segmentArr.push(spr);
			if (mdoBleed)
			{
			
			segmentSprites.push(spr);
			
			var ug:UniformGrowth = new UniformGrowth(spr, p1, p2, lineCol, 0, lWid, bTime,alp);
			ug.start(); 
			
			ugArr.push(ug);
			}
			else
			{
			spr.graphics.lineStyle(lWid,lineCol,alp);
			spr.graphics.moveTo(p1.x,p1.y);
			spr.graphics.lineTo(p2.x, p2.y);          
			}
			
			movePen(p1);
		}
		
		private function updateWidth():void
		{
			for (var d:int = 0; d < ugArr.length; d++)
			{
				ugArr[d].step();
			}
		}
		
		private function determineLineParameters(from:Point,to:Point,col:uint,speed:Number=5, wid:Number=1,widEnd:Number=-1,initA:Number=1,endA:Number=1,maxSegmentLength:Number=1):void
		{
			
		    if (widEnd ==-1)
			widEnd = wid;
			var step:Number;
			
			var x1:Number=from.x;
			var x2:Number=to.x;
			var y1:Number=from.y;
			var y2:Number=to.y;
			lineCol = col;
			lineWid = wid;
			currentAlpha = initA;
			
			var tx:Number=Math.abs(x1-x2);
			var ty:Number = Math.abs(y1 - y2);
			
			
			
			var st1 = tx/(speed*Global.FRAME_RATE);// speed * tx / (lineLength(from, to));
			var st2 = ty / (speed * Global.FRAME_RATE);// speed * ty / (lineLength(from, to));
			
			if (st1 > maxSegmentLength)
			st1 = maxSegmentLength;
			if (st2 > maxSegmentLength)
			st2 = maxSegmentLength;
			
			
			
			if(tx>=ty)
			step=st1;
			else
			step = st2;
			
			
			
			if(tx>=ty)
			{
			if(x2<x1)
			step*=-1;
			}else
			{
			if(y2<y1)
			step*=-1; 
			}
			
			
			var dx:Number=x1;
			var dy:Number=y1;
			
			m=(y1-y2)/(x1-x2);
			c=(x1*y2-y1*x2)/(x1-x2);
			M=(x1-x2)/(y1-y2);
			C=(y1*x2-x1*y2)/(y1-y2);
			
			pointList.push(from);
			
			if(tx>=ty)
			{
			if(step<0)
			while(x2<dx)
			{
				dx+=step;
				if(dx>x2)
				pointList.push(new Point(dx,getYfromX(dx)));
			}
			else
			while(x2>dx)
			{
				dx+=step;
				if(dx<x2)
				pointList.push(new Point(dx,getYfromX(dx)));
			}
			}else //-------yy----
			{
			if(step<0)
			while(y2<dy)
			{
				dy+=step;
				if(dy>y2)
				pointList.push(new Point(getXfromY(dy),dy));
			}
			else
			while(y2>dy)
			{
				dy+=step;
				if(dy<y2)
				pointList.push(new Point(getXfromY(dy),dy));
			}
			}
			
		   widIncrement = (widEnd - wid) / pointList.length;
		   alphaIncrement = (endA - initA) / pointList.length;
			
		  
		   
			pointList.push(to);
			
			
			  segmentPerFrame = (pointList.length - 1) / (speed * Global.FRAME_RATE);
		   
		  // trace(segmentPerFrame,"SegPerFrame");
		}
		
		private function getYfromX(xx:Number):Number 
		{
			return (m*xx+c);
		}
		
		private function getXfromY(yy:Number):Number
		{
			
		   return (M*yy+C);
		}

	}
	
}
