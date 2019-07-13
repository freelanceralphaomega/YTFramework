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
	public class INTRO_3 extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		
		
		public function INTRO_3() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
					var sArr:Array = [];
			var colArr:Array = [0x00CC00,0x00DD00,0x00EE00];
			var currentIndex:int = 0;
			var togSw:int = 0;
			for (var d:int = 0; d < 5; d++)
			{
				var sc:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0, 30, .1), 650/200, 1600 / 1), colArr[currentIndex], 2, 1600, 1200, [[0.5, 1800]],true,4,0,.03);
		        
				
				sc.rotation = d * 60;
				
				//sc.x = 600;
				//sc.y = 600;
				
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