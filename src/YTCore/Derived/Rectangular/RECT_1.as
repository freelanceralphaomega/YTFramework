package YTCore.Derived.Rectangular 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.PointConnector;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class RECT_1 extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var wid:Number = 1920;
		private var hei:Number = 1080;
		private var initPtX:Number = 0;
		private var initPtY:Number = 0;
		private var seq:Sequencer = new Sequencer();
		
		private var ptCon:PointConnector = new PointConnector([new Point(initPtX,initPtY),new Point(initPtX+wid,initPtY),new Point(initPtX+wid,initPtY+hei),new Point(initPtX,initPtY+hei),new Point(initPtX,initPtY)],0XDE8E64,5,60,60,null,!true,.5)
		
		public function RECT_1() 
		{
			super();
			
			addChild(ptCon);
			seq.initSequence([[ptCon,0]]);
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
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