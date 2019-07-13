package YTCore.Derived.ScreenFiller 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.GraphPaper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LineFillers extends Sprite implements IRenderable 
	{
		private var seq:Sequencer = new Sequencer();
		private var gp:GraphPaper = new GraphPaper(1920, 1080,400,400,2,2,4,4,0,0,0x008800,0x008800,250,250,0x008800,0x008800,4,250,250,250);
		private var canStep:Boolean = false;
		public function LineFillers() 
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