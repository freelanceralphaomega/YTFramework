package YTCore.Utils.Tweener 
{
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class AnimMath 
	{
		
		public function AnimMath() 
		{
			
		}
		
		public static function getValueAtFrame(frame:int,initVal:Number, finalVal:Number, time:Number, frameRate:int = 60):Number
		{
			return initVal + ((finalVal - initVal) / (time * frameRate)) * frame;
		}
		
		public static function degToRad(deg:Number):Number
		{
			return deg * (Math.PI / 180);
		}
		
	}

}