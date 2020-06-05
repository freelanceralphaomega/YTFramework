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
		//private var colArr:Array = [0xFF9933, 0xFFFFFF, 0x138808];
		private var colArr:Array = [0xFFFFFF,0x138808];
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
			trace(txt);
			tlineArr = txt.split("\r\n");
			
			for (var d:int = 0; d < tlineArr.length; d++)
			{
				//var rt:RunningText = new RunningText(tlineArr[d], "Arial", 20, [colArr[d % colArr.length]], tlineArr[d].length * .11);
				//var rt:RunningText = new RunningText(tlineArr[d], "Tunga", 25,[getCol(d)], tlineArr[d].length*.11);
				var rt:RunningText = new RunningText(tlineArr[d], "AR DECODE", 90,[0xFFFFFF], tlineArr[d].length*.11,false);
				rtArr.push(rt);
				rt.y = d * 35;
				addChild(rt);
			}
			
			Helper.addBackToBackDependency(seq,rtArr); 
		
		}
		
		private function getCol(d:int):uint
		{
			return 0xFFFFFF;
			
			if (d < tlineArr.length / 3)
			return colArr[0];
			if (d < 2 * tlineArr.length / 3-1) 
			return colArr[1];
			
			return colArr[2];
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			try{
			seq.step();
			}catch (e:Error)
			{
				stop();
			}
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