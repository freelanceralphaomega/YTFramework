package YTCore.Animators 
{
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ActionScheduler extends EventDispatcher implements IRenderable 
	{
		
		private var canDoStep:Boolean = false;
		private var obj:Object;
		private var method:String;
		private var delay:Number;
		private var maxCount:int;
		private var currentCount:int = 0;
		
		/**
		 * 
		 * @param	objx Target Object on which the method needs to be invoked
		 * @param	methodx Public method of the obj that need to be invoked
		 * @param	delayx delay in second after which method is called
		 */
		
		public function ActionScheduler(objx:Object,methodx:String,delayx:Number)
		{
			obj = objx;
			method = methodx;
			delay = delayx;
			maxCount = int(Global.FRAME_RATE * delay); 
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
			if (!canDoStep)
			return;
	
			
			if (currentCount >= maxCount)
			{
				stop();
				obj[method]();
				this.dispatchEvent(new YTEvent(YTEvent.FINISHED));  
				
			}
			currentCount++;
			
		}
		
		public function stop():void 
		{
			canDoStep = false;
		}
		
		public function start():void 
		{
			canDoStep = true;
		}
		
	}

}