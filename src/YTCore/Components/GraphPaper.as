package YTCore.Components 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Global;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class GraphPaper extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		
		private var seq:Sequencer = new Sequencer();
		
		private var mgraphWidth:Number;
		private var mgraphHeight:Number;
		private var mpixelPerUnitX:Number;
		private var mpixelPerUnitY:Number;
		private var mmainDivisionX:int;
		private var mmainDivisionY:int;
		private var msubdivisionCountX:int;
		private var msubdivisionCountY:int;
		private var morigX:int;
		private var morigY:int;
		private var mxAxisCol:uint;
		private var myAxisCol:uint;
		private var mxAxisWidth:Number;
		private var myAxisWidth:Number;
		private var msubDivisionColor:uint;
		private var mmainDivisionColor:uint;
		private var mdrawTime:Number;
		private var msubDivisionWidth:Number;
		private var mmainDivisitionWidth:Number;
		private var maxisWidth:Number;
		private var mboundingBoxColor:uint;
		private var mboundingBoxWidth:Number;
		private var mmarkingWidth:Number;
		
		private var mlabelColor:uint;
		private var mlabelFont:String;
		private var mlabelFontSize:Number;
		
		
		private var allHolder:Sprite = new Sprite();
		private var vLineHolder:Sprite = new Sprite();
		private var hLineHolder:Sprite = new Sprite();
		private var axisHolder:Sprite = new Sprite();
		private var boundingBoxHolder:Sprite = new Sprite();
		private var labelHolder:Sprite = new Sprite();
		private var markingHolder:Sprite = new Sprite();
		
		private var maxDelay:Number = 0;
		private var frameCount:Number = 0;
		
		private var labelEnabled:Boolean = true;
		
		
		private var hLineArr:Array = [];
		private var vLineArr:Array = [];
		

		
		 
		  /**
		   * 
		   * @param	graphWidth Width of the graph paper
		   * @param	graphHeight Height of the graph paper
		   * @param	pixelPerUnitX How many pixels are needed to represent 1 unit along X axis
		   * @param	pixelPerUnitY How many pixels are needed to represent 1 unit along Y axis
		   * @param	mainDivisionX After How many unit (X) a main division (Bold line) is shown 
		   * @param	mainDivisionY After How many unit (Y) a main division (Bold line) is shown 
		   * @param	subDivisionCountX Between two main divisions (X), how many subdivision to show
		   * @param	subDivisionCountY Between two main divisions (Y), how many subdivision to show
		   * @param	origX where to put the origin (X) with respect to bottom left corner of the graph paper
		   * @param	origY where to put the origin (Y) with respect to bottom left corner of the graph paper
		   * @param	xAxisCol Colour of the X Axis
		   * @param	yAxisCol Colour of the Y Axis
		   * @param	xAxisWidth Line Width along X axis
		   * @param	yAxisWidth Line width along Y axis
		   * @param	mainDivisionColor Colour along the Main divisions
		   * @param subDivisionColor Colour along the Sub divisions
		   * @param drawTime Time to draw a line
		   * @param subDivisionWidth Thickness of the subdivisions
		   * @param axisWidth Thickness of the Axis
		   */
		
		public function GraphPaper(
		graphWidth:Number=450,                
		graphHeight:Number=400,          
		pixelPerUnitX:Number=400/10,
		pixelPerUnitY:Number=400/10,  
		mainDivisionX:Number=1,   
		mainDivisionY:Number=1, 
		subDivisionCountX:int = 3, 
		subDivisionCountY:int=3,
		origX:int=0,                     
		origY:int=0,                     
		xAxisCol:uint=0xFFFF00,           
		yAxisCol:uint=0xFFFF00,               
		xAxisWidth:Number=2,                  
		yAxisWidth:Number=2,                
		subDivisionColor:uint=0xCCCCCC,      
		mainDivisionColor:uint=0xFFFFFF,     
		drawTime:Number=3,                  
		subDivisionWidth:Number=1,              
		mainDivisionWidth:Number = 2,
		axisWidth:Number = 2,
		boundingBoxColor:uint = 0xFFFFFF,
		boundingboxWidth:Number = 0,
        markingWidth:Number = 20,
		labelColor:uint=0xFFFFFF,
		labelFont:String = "Arial",
		labelFontSize = 10
		
		
		)                                         
		{
			super();
			
			//this.alpha = .3;
			
			mgraphWidth =         graphWidth;           
			mgraphHeight =        graphHeight;          
			mpixelPerUnitX =      pixelPerUnitX;        
			mpixelPerUnitY =      pixelPerUnitY;        
			mmainDivisionX =       mainDivisionX;       
			mmainDivisionY =      mainDivisionY;        
			msubdivisionCountX =   subDivisionCountX;   
			msubdivisionCountY = subDivisionCountY;     
 			morigX =              origX;                
			morigY =              origY;                
			mxAxisCol =        xAxisCol;                
			myAxisCol =        yAxisCol;                
			mxAxisWidth =      xAxisWidth;              
			myAxisWidth =      yAxisWidth;              
			msubDivisionColor = subDivisionColor;       
			mmainDivisionColor = mainDivisionColor;     
			mdrawTime = drawTime;                       
			msubDivisionWidth = subDivisionWidth;       
			mmainDivisitionWidth = mainDivisionWidth;   
			maxisWidth = axisWidth;
			mboundingBoxColor = boundingBoxColor;
			mboundingBoxWidth = boundingboxWidth;
			mmarkingWidth = markingWidth;
			
			
			mlabelColor      = labelColor;   
			mlabelFont       = labelFont;  
			mlabelFontSize   = labelFontSize;
			                                             
			this.addEventListener(Event.ADDED_TO_STAGE,  onStg);
		}
		
		public function set gridAlpha(alp:Number):void
		{
			hLineHolder.alpha = vLineHolder.alpha = alp;
		}
		
		private function hideAxisIfOutOfGraph():void
		{
		if (morigX < 0 || morigY < 0 || morigX * mpixelPerUnitX > mgraphWidth || morigY * mpixelPerUnitY > mgraphHeight)
		axisHolder.visible = false;
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			
			setup();
			
		}
		
		public function set showLabel(show:Boolean):void
		{
			labelEnabled = show;
		}
		
		public function get showLabel():Boolean
		{
			return labelEnabled;
		}
		
		private function setup():void
		{
			addChild(allHolder);
			allHolder.addChild(vLineHolder);
			allHolder.addChild(hLineHolder);
			allHolder.addChild(axisHolder);
			allHolder.addChild(boundingBoxHolder);
			allHolder.addChild(labelHolder);
			allHolder.addChild(markingHolder);
			
			allHolder.x -= morigX * mpixelPerUnitX;
			allHolder.y += morigY * mpixelPerUnitY;
			
			
		labelHolder.visible = false;
	       var currentY:Number = 0;
		   var distPerSubDivisionY:Number = mmainDivisionY * mpixelPerUnitY / msubdivisionCountY;
		   var count:int = 0;
		   
		   var currentX:Number = 0;
		   var distPerSubDivisionX:Number = mmainDivisionX * mpixelPerUnitX/msubdivisionCountX;
		   
		   var seqr:Array = [];
		   var markingArr:Array = [];
			while (Math.abs(currentY) <= mgraphHeight)
			{
				
				var dl:DLine;
				
				if (count % msubdivisionCountY != 0)
				{
				if(Math.random()>.5)
				dl = new DLine(new Point(0, currentY), new Point(mgraphWidth, currentY), msubDivisionColor, mdrawTime, msubDivisionWidth);
				else
				dl = new DLine(new Point(mgraphWidth, currentY),new Point(0, currentY),  msubDivisionColor, mdrawTime, msubDivisionWidth);
				}
				else
				{
				if(Math.random()>.5)
				dl = new DLine(new Point(0, currentY), new Point(mgraphWidth, currentY), mmainDivisionColor, mdrawTime, mmainDivisitionWidth);
				else
				dl = new DLine(new Point(mgraphWidth, currentY),new Point(0, currentY),  mmainDivisionColor, mdrawTime, mmainDivisitionWidth);
				
				
				var lab:TextLabel = new TextLabel(((count/msubdivisionCountX)*mmainDivisionY-morigY).toString(), mlabelColor, "Arial", 12,0xABCDEF,0,0,0,0,2,3);
				lab.y = currentY - lab.width / 2;
				lab.x -= lab.width +10;
				labelHolder.addChild(lab);
				
				var markingDlY:DLine = new DLine(new Point(-mmarkingWidth/2,currentY), new Point(mmarkingWidth/2,currentY), 0x000000, 1, 1);
				markingHolder.addChild(markingDlY);
				markingArr.push(markingDlY);
				
				var r1:Number =  Math.random();
				setMaxRandomTime(r1);
				seqr.push([markingDlY,r1]);
				
				}
				hLineArr.push(dl);
				hLineHolder.addChild(dl);
				currentY -= distPerSubDivisionY;
				var r2:Number = Math.random();
				setMaxRandomTime(r2);
				seqr.push([dl, r2]);
				
				count++;
			}
			
			count = 0;
			
			while (Math.abs(currentX) <= mgraphWidth)
			{
				var dl2:DLine;
				if(count%msubdivisionCountY!=0)
				dl2=new DLine(new Point(currentX, 0), new Point(currentX, -mgraphHeight), msubDivisionColor, mdrawTime, msubDivisionWidth);
				else
				{
				dl2 = new DLine(new Point(currentX, 0), new Point(currentX, -mgraphHeight), mmainDivisionColor, mdrawTime, mmainDivisitionWidth);
				
				var label:TextLabel = new TextLabel(((count/msubdivisionCountY)*mmainDivisionX-morigX).toString(), mlabelColor, "Arial", 12,0xFFFFFF,0xFFFFFF,1,0,0);
				label.x = currentX - label.width / 2;
				label.y += 10;
				labelHolder.addChild(label);
				
				var markingDlX:DLine = new DLine(new Point(currentX,-mmarkingWidth/2), new Point(currentX,mmarkingWidth/2), 0x000000, 1, 1);
				markingHolder.addChild(markingDlX);
				markingArr.push(markingDlX);
				
				var r3:Number = Math.random();
				setMaxRandomTime(r3);
				seqr.push([markingDlX, r3]);
				
				}
				vLineArr.push(dl2);
				vLineHolder.addChild(dl2);
				currentX += distPerSubDivisionX;
				
				var r4:Number = Math.random();
				setMaxRandomTime(r4);
				seqr.push([dl2, r4]);
				
				count++;
			}
			
			
			
			//Draw Y axis
			var dl3:DLine = new DLine(new Point(morigX * mpixelPerUnitX, -mgraphHeight),new Point(morigX * mpixelPerUnitX, 0), myAxisCol, mdrawTime, maxisWidth);
			axisHolder.addChild(dl3);
			
			
			//Draw X axis
			var dl4:DLine = new DLine(new Point(mgraphWidth, -morigY*mpixelPerUnitY),new Point(0,-morigY * mpixelPerUnitY), myAxisCol, mdrawTime, maxisWidth);
			axisHolder.addChild(dl4);
			
			//Draw Boundary
			var dl5:PointConnector=new PointConnector([new Point(0,0),new Point(0,-mgraphHeight),new Point(mgraphWidth,-mgraphHeight),new Point(mgraphWidth,0),new Point(0,0)], mboundingBoxColor, mdrawTime, mboundingBoxWidth);
			boundingBoxHolder.addChild(dl5);
			
			var r5:Number = Math.random();
			var r6:Number = Math.random();
			var r7:Number = Math.random();
			
			setMaxRandomTime(r5);
			setMaxRandomTime(r6);
			setMaxRandomTime(r7);
			
			
			seqr.push([dl3, r5]);
			seqr.push([dl4, r6]);
			seqr.push([dl5, r7]);
			
			var axisArr:Array = [dl3, dl4];
			
			
			
			hideAxisIfOutOfGraph();
		
			
			seq.register(hLineArr);
			seq.register(vLineArr);
			seq.register(axisArr);
			seq.register([dl5]);
			seq.register(markingArr);
			seq.initSequence(seqr);
		}
		
		
		private function setMaxRandomTime(testTime:Number):void
		{
			if (testTime > maxDelay)
			maxDelay = testTime;
		}
		
		public function plotPoints(ptArr:Array):void
		{
			for (var d:int = 0; d < ptArr.length; d++ )
			{
				plot(ptArr[d]);
			}
		}
		
		private function plot(pt:Point):void
		{
			var tl:TextLabel = new TextLabel("(" + pt.x.toString() + "," + pt.y.toString() + ")", 0x000000, "Arial", 10,0xFF00FF,0xCCCC00,1,1,1,1,1);
			labelHolder.addChild(tl);
			tl.x = (pt.x + morigX) * mpixelPerUnitX+2;
			tl.y = -(pt.y + morigY) * mpixelPerUnitY+2;
		}
		
		private function onFin():void 
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			
			if(showLabel)
			labelHolder.visible = true;
			stop();
		}
		
	
		private function checkForFinish():void
		{
			if ((maxDelay + mdrawTime) * Global.FRAME_RATE < frameCount)
			onFin();
			frameCount++;
		}
		
		
		private function distFromUnitScaleX(unit:Number):Number
		{
			return unit * mpixelPerUnitX;
		}
		
		private function distFromUnitScaleY(unit:Number):Number
		{
			return unit * mpixelPerUnitX;
		}
		
		private function unitFromPixelDistX(pixDist:Number):Number
		{
			return (pixDist / mpixelPerUnitX);
		}
		
		private function unitFromPixelDistY(pixDist:Number):Number
		{
			return (pixDist / mpixelPerUnitY);
		}
		
			
		/* ImsubdivisionNTERFACE Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			
			seq.step();
			checkForFinish();
		}
		
		public function stop():void 
		{
			canStep = false;
		}
		public function start():void 
		{
			canStep = true;
		}
		
	}

}