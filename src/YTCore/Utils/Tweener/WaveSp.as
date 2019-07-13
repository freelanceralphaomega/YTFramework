package YTCore.Utils.Tweener 
{
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Global;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class WaveSp extends EventDispatcher
	{
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
				//txtArr[d].y += Math.sin(phase * d)*offSet; 
			}
			totoalFrame = frate * time;
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