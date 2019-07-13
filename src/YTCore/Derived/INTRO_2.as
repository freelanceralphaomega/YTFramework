package YTCore.Derived 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.PointConnector;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.security.X509Certificate;
	
	/**
	 * ...
	 * @author ...
	 */
	public class INTRO_2 extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		
		
		public function INTRO_2() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
					var sArr:Array = [];
			var colArr:Array = [0xFFFFFF,0xFF0000,0xABCDEF,0xFFFF00];
			var currentIndex:int = 0;
			var togSw:int = 0;
			for (var d:int = 0; d < 14; d++)
			{
				var sc:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0, 2000/((1920+(d+2)*1200) / (2000)), 1), (1920+(d+2)*1200) / (2000), 100 / 1), colArr[currentIndex], 1.6 + 3 * Math.random(), 100, 100, [[0.5, 200]]);
				sc.y = d * 100-120;
				addChild(sc);
				sArr.push(sc);
				currentIndex++;
				if (currentIndex >= colArr.length)
				currentIndex = 0;
				if (togSw == 1)
				togSw = 0;
				else
				togSw = 1;
			}
			
		      Helper.drawParallelLineDrawing(seq,sArr);
		}
		
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