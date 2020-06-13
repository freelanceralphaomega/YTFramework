package YTCore.Derived.Circular 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DSegment;
	import YTCore.Components.PointConnector;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.security.X509Certificate;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CIRC_1 extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		
		
		public function CIRC_1() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
			var sArr:Array = [];
			var colArr:Array = [0x00CC00,0x00DD00,0x00EE00,0xFFFFFF,0x00DD00,0x00EE00,0x00CC00,0x00DD00,0x00EE00,0xFFFFFF,0x00DD00,0x00EE00,0x00DD00,0x00EE00,0x00CC00,0x00DD00,0x00EE00,0xFFFFFF,0x00DD00,0x00EE00,,0x00DD00,0x00EE00,0xFFFFFF,0x00DD00,0x00EE00,0x00DD00,0x00EE00,0x00CC00,0x00DD00,0x00EE00,0xFFFFFF,0x00DD00,0x00EE00,0x00EE00,0x00CC00,0x00DD00,0x00EE00,0xFFFFFF,0x00DD00,0x00EE00];
			var currentIndex:int = 0;
			var togSw:int = 0;
			for (var d:int = 1; d <= 40; d++)
			{
				var sc:DCircleSegment = new DCircleSegment(360,d*9, 0xFF0000,2*Math.random()+.5, 1.5, d % 2 == 0?1: -1);
		        
				
				//sc.rotation = d * 60;
				
				//sc.x = 600;
				//sc.y = 600;
				
				addChild(sc);
				sArr.push([sc,0]);
				currentIndex++;
				if (currentIndex >= colArr.length)
				currentIndex = 0;
				if (togSw == 1)
				togSw = 0;
				else
				togSw = 1;
			}
			
			seq.initSequence(sArr);
		      
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