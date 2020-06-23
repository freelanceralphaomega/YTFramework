package YTCore.Components.Animation 
{
	import YTCore.Events.YTEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author Sushil
	 */
	public class MovieClipSnapper extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var mclip:MovieClip;
		private var currentFrame:int = 1;
		private var maxFrame:int;
		public function MovieClipSnapper(mc:MovieClip,maxFr:int) 
		{
			super();
			mclip = mc;
			maxFrame = maxFr;
			addChild(mc);
			mc.gotoAndStop(1);
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			
			currentFrame++;
			mclip.gotoAndStop(currentFrame);
			
			if (currentFrame >= maxFrame)
			{
			stop();
			 this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			}
			
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