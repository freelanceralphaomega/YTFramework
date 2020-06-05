package YTCore.Utils.Tweener 
{
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Global;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class WaveSp extends EventDispatcher
	{
		private var dict:Dictionary = new Dictionary();
		private var arr:Array;
		private var offs:Number;
		private var frameCount:int = 1;
		private var totoalFrame:int;
		private var ph:Number;
		private var isCompleted:Boolean = false;
		public var enable:Boolean = true;
		public var waveScaling:Number = .5;
		public function WaveSp() 
		{
			
		}
		
		public function waveText(txtArr:Array,phase:Number,offSet:Number,time:Number,waveScale:Number=1,frate:int=60):void
		{
			ph = phase;
			arr = txtArr;
			offs = offSet;
			waveScaling = waveScale;
			for (var d:int = 0; d < txtArr.length; d++)
			{
				dict[txtArr[d]] = txtArr[d].y; 
			}
			totoalFrame = frate * time;
		}
		
		
		private function restoreOriginalPosition():void
		{
			for (var d:int = 0; d < arr.length; d++ )
			{
				arr[d].y=dict[arr[d]];
			}
		}
		
		public function step():void
		{
			if (!enable)
			return;
			if (isCompleted)
			return;
			
			if (frameCount >= totoalFrame)
			{
			isCompleted = true;
			restoreOriginalPosition();
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			return;
			}
			for (var d:int = 0; d < arr.length; d++)
			{
				
				arr[d].y+= waveScaling*Math.cos(frameCount*.1+ph*d); 
			}
			frameCount++;
		}
		
	}

}