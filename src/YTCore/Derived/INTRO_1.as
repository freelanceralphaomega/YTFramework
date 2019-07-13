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
	public class INTRO_1 extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		
		
		public function INTRO_1() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
					var sArr:Array = [];
			var colArr:Array = [0xCC0000, 0xCCCC00, 0xABCDEF, 0x3377CC];
			var currentIndex:int = 0;
			for (var d:int = 0; d < 11; d++)
			{
				var sc:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0, 2000, 1), 1024 / (2000+350*Math.random()), 50 / 1), colArr[currentIndex], 1.6 + 3 * Math.random(), 200, 60, [[0.5, 300],[.8,200]]);
				sc.y = d * 100;
				addChild(sc);
				sArr.push(sc);
				currentIndex++;
				if (currentIndex >= colArr.length)
				currentIndex = 0;
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