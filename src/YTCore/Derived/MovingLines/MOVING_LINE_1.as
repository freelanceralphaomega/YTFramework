package YTCore.Derived.MovingLines 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DLine;
	import YTCore.Components.GraphPaper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MOVING_LINE_1 extends Sprite implements IRenderable 
	{
		private var col:uint = 0x00CC00;
		private var seq:Sequencer = new Sequencer();
		private var gp:DLine = new DLine(new Point(100, 100), new Point(1800, 100), col, 5, 50, 50, true, 1);
		private var gp2:DLine = new DLine(new Point(1800,100),new Point(100,100), col, 5, 50, 50, true, 1);
		private var canStep:Boolean = false;
		public function MOVING_LINE_1() 
		{
			super();
			
			addChild(gp);
			addChild(gp2);
			
			gp2.y = 200;
		
			seq.initSequence([[gp,0],[gp2,0]]);
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
			canStep  = true;
		}
		
	}

}