package YTCore.Animators 
{

	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class Sequencer
	{
		private var seqArr:Array;
		private var frameCount:int = 0;
		
		private var reg:Array = [];
		
		public function Sequencer() 
		{
			
		}
		/**
		 * <code>setSequence</code> is for setting up objects that implements IRenderable interface.
		 * 
		 * @param seq Sequence of Array [[R1,t1],[R2,t2],[R3,t3]...,[Rn,tn]], Where R=Renderable Object, t=time of activation
		 */
		public function initSequence(seq:Array):void
		{
			seqArr = seq; 
			
			for (var d:int = 0; d < seqArr.length; d++)
			{
					(seqArr[d][0]).start();
			}
		} 
		
		/**
		 * 
		 * @param	r Register IRenderable objects that is not part of timing sequence [r1,r2,r3....rn]
		 */
		
		public function register(r:Array):void
		{
			for (var d:int = 0; d < r.length; d++ )
			{
			reg.push(r[d]);
			}
		}
		
		public function addDependency(master:*,slave:*,evt:String):void
		{
			master.addEventListener(evt, function(e:YTEvent):void{slave.start()}); 
		}
		
		public function step():void
		{
			for (var d:int = 0; d < seqArr.length; d++)
			{
				if (frameCount>=seqArr[d][1] * Global.FRAME_RATE)
				{
					(seqArr[d][0] as IRenderable).step();
				}
			}
			
			
			for (var k:int = 0; k < reg.length; k++ )
			{
				reg[k].step();
			}
			
			frameCount++;
		}
		
		
		
	}

}