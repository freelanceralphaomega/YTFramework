package YTCore.Components.Text 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Global;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MultilineRunningText extends Sprite implements IRenderable 
	{
		
		private var tlineArr:Array = [];
		private var rtArr:Array = [];
		private var seq:Sequencer = new Sequencer();
		private var canStep:Boolean = false;
		
		
		
		public function MultilineRunningText(tname:String) 
		{
			super();
			
			
			setup(tname);
		}
		
		
		private function setup(tname:String):void
		{
			var txt:String = FileLoader.readMLText(tname);
			tlineArr = txt.split("\r\n");
			
			for (var d:int = 0; d < tlineArr.length; d++)
			{
				var rt:RunningText = new RunningText(tlineArr[d], "Arial", 20, [0x000000], .4);
				rtArr.push(rt);
				rt.y = d * 25;
				addChild(rt);
			}
			
			Helper.addBackToBackDependency(seq,rtArr);
		
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