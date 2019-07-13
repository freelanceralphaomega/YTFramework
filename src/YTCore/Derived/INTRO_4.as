package YTCore.Derived 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DLine;
	import YTCore.Components.PointConnector;
	import YTCore.Graphics.TextureLibrary;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	import flash.security.X509Certificate;
	
	/**
	 * ...
	 * @author ...
	 */
	public class INTRO_4 extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		
		
		public function INTRO_4() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
					var sArr:Array = [];
			var colArr:Array = [0x138808,0xFFFFFF,0xFF9933,0x005500, 0x006600, 0x007700, 0x008800];
			var prand:Array = [.1, .2, .8, .6, .3, .9, .65, .39, .82, .22, .18, .01, .39];
			var prand2:Array = [.71,.32,.48,.16,.73,.39,.55,.39,.02,.12,.18,.61,.89];
			var currentIndex:int = 0;
			var togSw:int = 0;
			for (var d:int = 0; d <1; d++)
			{
				var sc:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getTanPtArr(-83,80,1),200/80,50/1),colArr[currentIndex],4,900,900,[[.5,1600]],true,3);
		        
				
				sc.rotation = d * 60;
				
				sc.x = 350+600*(prand[d]-.5);
				sc.y = 300+600*(prand2[d]-.5);
				
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