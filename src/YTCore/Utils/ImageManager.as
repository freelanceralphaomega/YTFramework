package YTCore.Utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ImageManager 
	{
		
		public function ImageManager() 
		{
			
		}
		
		public static function getImageFromText(txtf:TextField):Bitmap
		{
			var bmd:BitmapData = new BitmapData(txtf.textWidth+5, txtf.textHeight+5,true,0xFF0000);
			
			trace(txtf.textWidth,txtf.textHeight);
		
			
			bmd.draw(txtf,null,null,null,null,true);
			
			var bm:Bitmap = new Bitmap(bmd);
			return bm;
		}
	}

}