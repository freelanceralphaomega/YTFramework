package YTCore.Derived 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.GraphPaper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class INTRO_GRAPH extends Sprite implements IRenderable 
	{
		private var seq:Sequencer = new Sequencer();
		private var gp:GraphPaper = new GraphPaper(1920, 1080, 10, 10, 5, 5, 5, 5, 0, 0, 0x00D9D9, 0x00D9D9, 1, 1, 0x00D9D9, 0x00D9D9, 3, 1, 2, 1);
		private var canStep:Boolean = false;
		public function INTRO_GRAPH() 
		{
			super();
			
			addChild(gp);
			gp.y = 1080;
			seq.initSequence([[gp,0]]);
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