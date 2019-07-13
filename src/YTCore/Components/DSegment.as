package YTCore.Components 
{
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import YTCore.Utils.SegmentManager;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class DSegment extends Sprite implements IRenderable
	{
		private var ang:Number;
		private var col:uint;
		private var direction:int;
		private var rad:Number;
		private var time:Number;
		private var canStep:Boolean = false;
		private var anglePerStep:Number;
		private var currentAngle:Number = 0;
		private var holder:Sprite = new Sprite();
		
		/**
		 * 
		 * @param	segmentAng segment Angle counter clock wise, when dir=1
		 * @param	segmentRad Radius of the segment
		 * @param	segmentCol Colour of the segment
		 * @param	tim Time takes to render the complete segment
		 * @param	dir direction of angle: 1 when anti clock wise, -1 when clock wise
		 */
		public function DSegment(segmentAng:Number,segmentRad:Number,segmentCol:uint,tim:Number,dir:int=1) 
		{
			super();
			
			anglePerStep = segmentAng / (Global.FRAME_RATE*tim);
			ang = segmentAng;
			col = segmentCol;
			rad = segmentRad;
			direction = dir;
			
			addChild(holder);
			holder.x =-rad;
			holder.y =-rad;
			if (direction ==-1)
			this.scaleY =-1;
			
		}
		
		public function start():void
		{
			canStep = true;
		}
		
		public function stop():void
		{
			canStep = false;
		}
		
		public function step():void
		{
			if (!canStep)
			return;
			clear();
			
			holder.addChild(SegmentManager.gSpr(col, currentAngle, rad));
			currentAngle+= anglePerStep;
			if (currentAngle >= ang)
			{
			canStep = false;
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			}
		}
		
		private function clear():void
		{
			while (holder.numChildren > 0)
			{
				holder.removeChild(holder.getChildAt(0));
			}
		}
		
		
	}

}