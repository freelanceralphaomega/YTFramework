package YTCore.Animators 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class PathTraverser extends EventDispatcher implements IRenderable
	{
		private var canStep:Boolean = false;
		private var mpath:Array;
		private var mobj:DisplayObject;
		private var currentIndex:int = 0;
		private var skippedFrames:int = 0;
		private var objX:Number;
		private var objY:Number;
		
		private var mspeed:Number;
		
		
		public function PathTraverser(path:Array, obj:DisplayObject, speed:Number=1) 
		{
			mobj = obj;
			mspeed = speed;
			
			objX = obj.x;
			objY = obj.y;
			
			mpath = MathHandler.shiftRefPoint(path,objX,objY);
		}
		
		
		public function step():void
		{
			if (!canStep)
			return;
			
			
			if (mspeed >= 0.5)
			{
				mspeed = MathHandler.getNearestInteger(mspeed);
				
				for (var d:int = 0; d < mspeed; d++)
				{
					gotoNextPoint();
				}
				
			}else
			{
				
				
				mspeed = MathHandler.getNearestInteger(1 / mspeed)-1;
				
				if (skippedFrames == mspeed)
				{
					gotoNextPoint();
					skippedFrames = 0;
				}
				else
				{
					currentIndex++;
				
				}
				
			}
			
			
			if (currentIndex >= mpath.length)
			{
			stop();
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			}
			
		}
		
		
		
		private function gotoNextPoint():void
		{
			if (currentIndex >= mpath.length)
			return;
			
			mobj.x = mpath[currentIndex].x;
			mobj.y = mpath[currentIndex].y;
			
			currentIndex++;
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