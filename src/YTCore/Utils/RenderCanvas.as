package YTCore.Utils 
{
	import com.flashSpider.Graphics.Drawing;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class RenderCanvas extends Sprite 
	{
		private var bgSpr:Sprite = new Sprite();
		private var canv:Sprite = new Sprite(); 
		
		public function RenderCanvas(wid:Number,hei:Number,col:uint=0x000000,borderCol:uint=0xABCDEF) 
		{
			super();
			
			addChild(bgSpr);
			addChild(canv);
			
			Drawing.drawRectangle(bgSpr,hei,wid,0,0,true,col,borderCol);
		}
		
	
		
		public function get RENDER_CANVAS():Sprite
		{
			return canv;
		}
		
		public function addToCanvas(obj:DisplayObject):void
		{
			canv.addChild(obj);
		}
		
	}

}