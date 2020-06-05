package YTCore.Derived.Patterns 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Abstract.Math.PatternGenerators;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DSketch;
	import YTCore.Components.PointConnector;
	import YTCore.Components.Templates.LineArt;
	import YTCore.Components.Templates.LineDrawing;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	
	 
	public class Pattern_P3 extends Sprite implements IRenderable
	{
	 private var canStep:Boolean = false;
	 private var seq:Sequencer = new Sequencer();
	 
		public function Pattern_P3() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
			var col:uint = uint("0xFFFFFF");
			var animArr:Array = [];
			var colArr:Array = [0x210040,0x420080,0x8400FF,0x7700E6,0x6400C2];
	        var color:uint;
			var maxseg:int = 0;
			var maxAng:Number = 360;
			for (var d:int = 0; d <= maxseg; d++ )
			{
				
			 color = colArr[d];
			 
			 if (d > maxseg / colArr.length)
			 color = colArr[1];
			 
			  if (d > 2*maxseg / colArr.length)
			 color = colArr[2];
			 
			  if (d > 3*maxseg / colArr.length)
			 color = colArr[3]; 
			 
			  if (d > 4*maxseg / colArr.length)
			 color = colArr[4]; 
			
				
			var sinArr:Array = Helper.getArrayFromStringEquivalent(FileLoader.readShape("MERILYN_a"));
			var ptCon:LineDrawing = new LineDrawing(sinArr, 2, !true, color,2);
			//ptCon.rotation = -d * (maxAng / maxseg);
			//ptCon.scaleX = ptCon.scaleY = 1-(1 / maxseg) * d;
			//ptCon.alpha = .2+(1 / maxseg) * d;
			//ptCon.x = d * 20;
			//ptCon.x = d * 20;
			//ptCon.scaleX = d * 1.01;
			//ptCon.alpha = 1-d * (1 / 20);
			//ptCon.x = 1920/2;
			//ptCon.y = 1080/2; 
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