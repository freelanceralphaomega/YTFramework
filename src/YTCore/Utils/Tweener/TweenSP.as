package YTCore.Utils.Tweener 
{
	import AnimEvent.AEvent;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TweenSP extends EventDispatcher
	{
		private var currentFrame:int = 0;
		private var ob:Object;
		private var tt:Number;
		private var fr:int;
		private var prop:String;
		private var totFrame:int;
		private var initV:Number;
		private var fVal:Number;
		private var isCompleted:Boolean = false;
		public var enable:Boolean = true;
		public function TweenSP() 
		{
			
		}
		
		public function to(obj:Object, finalVal:Number, time:Number, frate:int, property:String)
		{
			ob = obj;
			tt = time;
			fr = frate;
			prop = property;
			totFrame = frate * time;
			initV = obj[property];
			fVal = finalVal;
		}
		
		public function step():void
		{
			if (!enable)
			return;
			if (isCompleted)
			return;
			if (currentFrame > totFrame)
			{
			isCompleted = true;
			this.dispatchEvent(new AEvent(AEvent.COMPLETE));
			return;
			}
			ob[prop] = AnimMath.getValueAtFrame(currentFrame, initV, fVal, tt, fr);
			currentFrame++;
		}
		
	}

}