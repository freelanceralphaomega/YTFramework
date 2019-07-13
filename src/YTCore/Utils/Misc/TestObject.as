package YTCore.Utils.Misc 
{
	import com.flashSpider.Graphics.Drawing;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TestObject extends Sprite 
	{
		public function TestObject() 
		{
			super();
			
			Drawing.drawCircle(this, 20, 0, 0, true, 0xCC0000,0xFF0000);
		}
		
	}

}