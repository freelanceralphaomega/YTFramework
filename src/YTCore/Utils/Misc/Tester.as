package YTCore.Utils.Misc 
{
	import YTCore.Abstract.Math.COMMON.MathFunction;
	import YTCore.Abstract.Math.COMMON.UtilMathFunction;
	import YTCore.CustomScript.ScriptManager;
	import YTCore.Utils.ExpressionHandler.ExpressionEvaluator;
	import YTCore.Utils.FileManager.ConfigManager;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Helper;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class Tester 
	{
		public static var enabled:Boolean = !true;
		public function Tester() 
		{
			
		}
		
		public static function test():void
		{
			trace("TEST------------------------------------------------------------------------------------------------------");
			

			trace("TESTER: ",ScriptManager.replaceVariables("$a=5;$b=6;$c=1.3;$d=$a+$b+$c;$e=$d+$a;$f=$e+$a;m=$f")); 
			
			//trace(ExpressionEvaluator.replaceAddition("$d=-7.1+6"));
			
			trace("TEST_END------------------------------------------------------------------------------------------------------");
		}
		
		
	}

}