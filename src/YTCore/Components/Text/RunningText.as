package YTCore.Components.Text 
{
	import YTCore.Events.YTEvent;
	import YTCore.Utils.AnimText.SplitText;
	import YTCore.Utils.Global;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RunningText extends Sprite implements IRenderable 
	{
		
		private var sText:SplitText;
		private var framePerLetter:Number;
		private var fArr:Array;
		
		private var canStep:Boolean = false;
		
		private var fCount:int = 0;
		private var currentLetterIndex:int = 0;
		
		/**
		 * 
		 * @param	txt Text
		 * @param	font Font
		 * @param	colArr Colour of the words separated by space. Colors gets repeated after array is exhausted	
		 * @param   time  Time in seconds to finish writing the text
		 * @param	useBitmap Set to true when fonts needs to be rotated..
		 */
		public function RunningText(txt:String,font:String, fontSize, colArr:Array,time:Number,useBitmap:Boolean=true) 
		{
			super();
			
			sText = new SplitText(txt, font, fontSize, colArr, useBitmap);
			addChild(sText);
			
			framePerLetter = Global.FRAME_RATE * time / sText.alphabets.length;
			
			setup();
			
		}
		
		private function setup():void
		{
			fArr = sText.alphabets;
			
			for (var d:int = 0; d < fArr.length; d++)
			{
				fArr[d].visible = false;
			}
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
		    return;
			
			if (fCount == 0)
			{
			fArr[currentLetterIndex].visible = true;
			currentLetterIndex++;
			}
			fCount++;
			
			if (fCount >= framePerLetter)
			fCount = 0;
			
			if (currentLetterIndex == fArr.length)
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