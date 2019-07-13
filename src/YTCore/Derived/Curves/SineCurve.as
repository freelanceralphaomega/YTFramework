package YTCore.Derived.Curves 
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
	public class SineCurve extends Sprite implements IRenderable 
	{
		private var seq:Sequencer = new Sequencer();
		private var canStep:Boolean = false;
		private var ptCon:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0,540,1),1600/540,200),0x006600,5,200,10,[[.3,100]],true,1);
		public function SineCurve() 
		{
			super();
			
			addChild(ptCon);
			seq.initSequence([[ptCon,0]]);
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
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