package YTCore.Components.Templates 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.PointConnector;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class LineDrawing extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		
		private var timePerUnitLength:Number = 1 / 100;
		private var mtime:Number;
		private var mcol:Number;
		private var mwid:Number;
		private var isParallelDrawing:Boolean = false;
		
		private var curveArr:Array = [];
		
		private var seq:Sequencer = new Sequencer();
		
		private var penL:Sprite;
		
		
		private var pointArr:Array;
		
		/**
		 * 
		 * @param	pts Array structure: [[[x1,y1],[x2,y2],[x3,y3],[x4,y4]],[[x'1,y'1],[x'2,y'2],[x'3,y'3],[x'4,y'4]]]
		 * @param	speed Speed of drawing
		 * @param	col Colour of the path
		 * @param   parallelDraw Start drawing all the segments simultaneously
		 * @param	wid Width of the line
		 */
		public function LineDrawing(pts:Array,time:Number,parallelDraw:Boolean=false,col:uint=0xCCCCCC,wid:Number=3,p:Sprite=null) 
		{
			super();
			
			pointArr = pts;
			mtime = time;
			mcol = col;
			mwid = wid;
			isParallelDrawing = parallelDraw;
			
			if (pts.length == 1)
			isParallelDrawing = true;
			
			
			
			
			penL = p;
			
			
			timePerUnitLength = time / MathHandler.getDistanceOfLineArt(pts);
			
			setup();
		}
		
		private function setup():void
		{
		  
		for (var d:int = 0; d < pointArr.length; d++)
		{
			var ptArr:Array = Helper.pointsFromArr(pointArr[d]);
			
			var time:Number = MathHandler.getTotalDistance(ptArr) * timePerUnitLength;
			
			if (isParallelDrawing)
			time = mtime;
			
			var ptCon:PointConnector = new PointConnector(ptArr, mcol, time, mwid,-1,null,false,1,1,1,2,false,penL);
			
			addChild(ptCon);
			curveArr.push(ptCon);
		}
	     
		
		if (isParallelDrawing)
		Helper.drawParallelLineDrawing(seq, curveArr);
		else
		{
		 Helper.addBackToBackDependency(seq, curveArr);
		
		}
		
		curveArr[curveArr.length - 1].addEventListener(YTEvent.FINISHED, onComp);
			
		}
		
		
		
		private function onComp(e:YTEvent):void
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			trace("Drawing Completed");
		}
		
		private function onFin(e:YTEvent):void 
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
		}
		
		
		public function set pen(p:Sprite):void
		{
			penL = p;
		}
		
		/* INTERFACE Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			
			
			seq.step();
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