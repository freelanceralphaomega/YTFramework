package YTCore.Utils 
{
	import com.flashSpider.Effects.EffectCreator;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class StyleEditor 
	{
		
		public function StyleEditor() 
		{
			
		}
		
		public static function applyShadow(obj:DisplayObject):void
		{
			EffectCreator.applyGlow(obj, 0x000000, 10, 10);
		}
		
	}

}