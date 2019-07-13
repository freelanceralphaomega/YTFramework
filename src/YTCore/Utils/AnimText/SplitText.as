package YTCore.Utils.AnimText 
{
	import YTCore.Utils.Global;
	import YTCore.Utils.ImageManager;
	import com.flashSpider.ImageHandler.ImageHandler;
	import com.flashSpider.Text.TextHandler;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class SplitText extends Sprite 
	{
		
		public var alphabets:Array = [];
		private var holder:Sprite = new Sprite();
		private var fontName:String = "Arial";
		private var txtHolder:Array = [];
		private var currentTxtPos:Number = 0;
		private var tNum:Number;
		private var wordCol:Array;
		private var wordColIndex:int = 0;
		private var useBitmapText:Boolean = false;
		
		
		public function SplitText(txt:String,fnt:String,txtSize:Number,wordColArrary:Array,useBm:Boolean=false) 
		{
			super();
			
			
			
			
			addChild(holder);
			//holder.y = -50;
			txtHolder = txt.split("");
			fontName = fnt;
			tNum = txtSize;
			wordCol = wordColArrary;
			useBitmapText = useBm;
			
			arrangeText(txtHolder);
		}
		

		
		private function arrangeText(txa:Array):void
		{
			
			for (var d:int = 0; d < txa.length; d++ )
			{
				var tf:TextField = TextHandler.setText(holder, txa[d], fontName, currentTxtPos, 0, wordCol[wordColIndex], tNum);
				
				var bm:Bitmap;
				
				if (useBitmapText)
				{
				if (txa[d] != " ")
				{
				bm=ImageManager.getImageFromText(tf);
				holder.addChild(bm);
				bm.x = currentTxtPos;
				alphabets.push(bm);
				tf.parent.removeChild(tf);
			}}
				else
				{
					holder.addChild(tf)
					tf.x = currentTxtPos;
					alphabets.push(tf);
				}
				
				
				currentTxtPos += tf.textWidth;
				if (txa[d] == " ")
				{
				currentTxtPos += 25;
				wordColIndex++;
				if (wordColIndex == wordCol.length)
				wordColIndex = 0;
				}
			}
		}
		
		
		
	}

}