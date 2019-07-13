package YTCore.Effects 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class EffectPreset 
	{
		
		public function EffectPreset() 
		{
			
		}
		
		public static function SOFT_SHADOW(target:Sprite):Sprite
		{
			var sh:shadow = new shadow();
			var p:Sprite = target.parent as Sprite;
			
			sh.EFF.addChild(target);
			p.addChild(sh);
			
			return sh;
		}
		
		public static function SOFT_BEVEL(target:Sprite):Sprite
		{
			var sh:bevel = new bevel();
			var p:Sprite = target.parent as Sprite;
			
			sh.EFF.addChild(target);
			p.addChild(sh);
			
			return sh;
			
		}
		
	}

}