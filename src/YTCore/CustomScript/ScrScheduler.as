package YTCore.CustomScript 
{
	import YTCore.Components.DSegment;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ScrScheduler implements IRenderable
	{
		
		private var canStep:Boolean = false;
		private var frameCount:int = 0;
		
		private var obj:EventDispatcher;
		private var ds:Array;
		private var es:Array;
		
		/**
		 * 
		 * @param	entity Entity that dispatches 
		 * @param	dispatchSchedule
		 * @param	excutionSchedule
		 */
		public function ScrScheduler(entity:EventDispatcher,dispatchSchedule:Array,excutionSchedule:Array) 
		{
			obj = entity;
			ds = dispatchSchedule;
			es = excutionSchedule;
			
			
		}
		
		
		public function step():void
		{
			if (!canStep)
			return;
			
			
			for (var d:int = 0; d < ds.length; d++)
			{
				if (ds[d] != null)
				{
				var m:Number = Number(ds[d][0]);
				
				
				if (frameCount>=m * Global.FRAME_RATE)
				{
					obj.dispatchEvent(new ScriptEvent(ScriptEvent.DISPATCH, ds[d][1]));
					
				
					
					ds[d] = null;
				}
				}
			}
			
			for (var k:int = 0; k < es.length; k++)
			{
				if (es[k] != null)
				{
				var r:Number = Number(es[k][0]);
				if (frameCount>=r * Global.FRAME_RATE)
				{
					obj.dispatchEvent(new ScriptEvent(ScriptEvent.EXECUTE,es[k][1]));
					es[k] = null;
				}
				}
			}
			
			frameCount++;
		}
		
		public function start():void
		{
			canStep = true;
		}
		
		public function stop():void
		{
			canStep = false;
		}
		
	}

}