package YTCore.Animators 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TimeAnimation extends EventDispatcher implements IRenderable
	{
		private var canStep:Boolean = false;
		private var mobj:DisplayObject;
		private var totalFrames:Number;
		private var frameCount:int = 0;
		
		private var timeUnitPerFrame:Number = .1;
		private var xArr:Array = [];
		private var yArr:Array = [];
		
		private var initX:Number;
		private var initY:Number;
		
		private var spd:Number;
		private var amplitudeScaling:Number;
		
		
		/**
		 * 
		 * @param	obj object that need to be moved
		 * @param	time total time of the animation in seconds
		 * @param	xtFn change in x wrt t per frame
		 * @param	xyFn function of y wrt x that defines the path of the object
		 * @param	refSpeed provide a reference speed, e.g: how much distance (pixels) it moves in 1 second?
		 */
		public function TimeAnimation(obj:DisplayObject,time:Number,xtFn:Function,xyFn:Function,pixelPerUnitX:Number,pixelPerUnitY:Number,speed:Number=1,ampScale:Number=1) 
		{
			spd = speed;
			amplitudeScaling = ampScale;
			mobj = obj;
			totalFrames = time * Global.FRAME_RATE;
			
			var stepCount:int = 0;
			var currentTime:Number = 0;
			
			initX  = obj.x;
			initY =  obj.y;
			
			while (stepCount < totalFrames)
			{
				xArr.push(ampScale*200*xtFn(stepCount*.01*speed));
				currentTime+= timeUnitPerFrame;
				stepCount++;
			}
			
			var unitX:Array = [];
			
			for (var d:int = 0; d < xArr.length; d++ )
			{
				unitX.push(xArr[d]/pixelPerUnitX);
			}
			
			yArr = MathHandler.getMappedValues(unitX, xyFn);
			
			for (var d:int = 0; d < yArr.length; d++ )
			{
				yArr[d] = pixelPerUnitY * yArr[d];
			}
			
			
			
		}
		
		
		private function updatePosition():void
		{
			
			if (frameCount >= yArr.length)
			{
			stop();
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			return;
			}
			
			mobj.x = initX + xArr[frameCount];
			mobj.y = initY + yArr[frameCount];
			frameCount++;
		}
		
		
		
		public function step():void
		{
			if (!canStep)
			return;
			
			updatePosition();
			
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