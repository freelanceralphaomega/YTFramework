package YTCore.Components.CompoundComps 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.PointConnector;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class DHair extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		public function DHair() 
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
			var seqArr:Array = [];
			var col:uint;
			for (var d:int = 0; d < 30; d++ )
			{
			if (d>=0 && d <= 10)
			col = 0xFF0000;
			if (d>10 && d <= 20)
			col = 0xBBBBBB;
			if (d > 20)
			col = 0x00CC00;
			var ptCon:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0,450,.2),300/720,100/1),col,5,1,1,[[.5,30]],true,2);
			//ptCon.y = d * 10;
			ptCon.rotation = d * 2;
			addChild(ptCon);
			ptCon.scaleX =-1;
			ptCon.scaleY = -1;
			seqArr.push([ptCon,Math.random()]);
			
			}
			
			
				seq.initSequence(seqArr);
			
			
		}
		
		
		
		/* INTERFACE Interface.IRenderable */
		
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