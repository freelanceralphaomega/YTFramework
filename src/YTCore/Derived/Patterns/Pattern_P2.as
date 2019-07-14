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
	
	 
	public class Pattern_P2 extends Sprite implements IRenderable
	{
	 private var canStep:Boolean = false;
	 private var seq:Sequencer = new Sequencer();
	 
		public function Pattern_P2() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
			var col:uint = uint("0xFFFFFF");
			var animArr:Array = [];
			var colArr:Array = [0x8AA3FF,0xA352EB,0xFF007B,0xE8450C,0xFFDB9C];
	        var color:uint;
			var maxseg:int = 160;
			var maxAng:Number = 360;
			for (var d:int = 0; d <= maxseg; d++ )
			{
				
			 color = colArr[0];
			 
			 if (d > maxseg / colArr.length)
			 color = colArr[1];
			 
			  if (d > 2*maxseg / colArr.length)
			 color = colArr[2];
			 
			  if (d > 3*maxseg / colArr.length)
			 color = colArr[3]; 
			 
			  if (d > 4*maxseg / colArr.length)
			 color = colArr[4]; 
			
				
			var sinArr:Array = MathHandler.unitToPixelCoordinate(PatternGenerators.pattern_P1(0, 1400,10),1920/(2800),1080/(10));
			var ptCon:PointConnector = new PointConnector(sinArr, color,10, 5,1, [], !true);
			ptCon.rotation = -d * (maxAng / maxseg);
			//ptCon.scaleX = ptCon.scaleY = Math.sin(100*d);
			//ptCon.x = d * 20;
			//ptCon.x = d * 20;
			//ptCon.scaleX = d * 1.01;
			//ptCon.alpha = 1-d * (1 / 20);                
			ptCon.x =1920 /2;
			ptCon.y = 1080/2;
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