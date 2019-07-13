package YTCore.Graphics 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TextureLibrary 
	{
		
		public function TextureLibrary() 
		{
			
		}
		
		public static function get RED_1():Sprite
		{
			var spr:Sprite = new Sprite();
			
			var t:redTexture = new redTexture();
			
			spr.addChild(t);
			
			t.x = -t.width / 2;
			t.y = -t.height / 2;
			
			return spr;
		}
		
		public static function get RED_2():Sprite
		{
			var spr:Sprite = new Sprite();
			
			var t:red_2 = new red_2();
			
			spr.addChild(t);
			
			t.x = -t.width / 2;
			t.y = -t.height / 2;
			
			return spr;
		}
		
		public static function get RED_3():Sprite
		{
			var spr:Sprite = new Sprite();
			
			var t:red3 = new red3
			
			spr.addChild(t);
			
			t.scaleX = t.scaleY = 1.5;
			
			t.x = -t.width / 2;
			t.y = -t.height / 2;
			
			
			
			return spr;
		}
		
		public static function get GOLD_1():Sprite
		{
			var spr:Sprite = new Sprite();
			
			var t:gold1 = new gold1();
			
			spr.addChild(t);
			

			
			t.x = -t.width / 2;
			t.y = -t.height / 2;
			
			
			
			return spr;
		}
		
		
	}

}