package YTCore.Derived.Patterns 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Abstract.Math.PatternGenerators;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.PointConnector;
	import YTCore.Interface.IRenderable;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	
	 
	public class Pattern_P1 extends Sprite implements IRenderable
	{
	 private var canStep:Boolean = false;
	 private var seq:Sequencer = new Sequencer();
	 
		public function Pattern_P1() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
			var col:uint = uint("0xFFFFFF");
			var animArr:Array = [];
			var colArr:Array = [0x0444bf,0x0584f2,0xedf259,0x0aaff1];
	        var color:uint;
			var maxseg:int = 150;
			var maxAng:Number = 240;
			for (var d:int = 0; d <= maxseg; d++ )
			{
				
			 color = colArr[0];
			 
			 if (d > maxseg / colArr.length)
			 color = colArr[1];
			 
			  if (d > 2*maxseg / colArr.length)
			 color = colArr[2];
			 
			  if (d > 3*maxseg / colArr.length)
			 color = colArr[3]; 
			
				
			var sinArr:Array = MathHandler.unitToPixelCoordinate(PatternGenerators.pattern_P1(0, 360,1),450/(360),350/1);
			var ptCon:PointConnector = new PointConnector(sinArr, color, 5, .1, .1, [], !true);
			ptCon.rotation = d * (maxAng / maxseg);
			//ptCon.x = d * 20;
			//ptCon.x = d * 20;
			//ptCon.scaleX = d * 1.01;
			//ptCon.alpha = 1-d * (1 / 20);
			ptCon.x = 600
			ptCon.y = 500;
			addChild(ptCon);
			
				animArr.push([ptCon, 1.5+2*Math.random()]);
			}
		
			
			seq.initSequence(animArr);
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