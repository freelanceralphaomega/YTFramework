package YTCore.Utils.ExpressionHandler 
{

	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ExpressionEvaluator 
	{
		
		public function ExpressionEvaluator() 
		{
			
		}
		
		
		
		public static function evaluateAndReplace(exp:String):String
		{
			exp = replaceDivision(exp);
			exp = replaceMultiplication(exp);
			exp = replaceAddition(exp);
			exp = replaceSubraction(exp);
			
			return exp;
		}
		
		
		
		public static function replaceDivision(src:String):String
		{
		
		  var rExp:RegExp = /-?[\d\.]+s*\/\s*[\d\.]+/;
		   
		   
		   while (rExp.test(src))
		   {
			   var exp:String = rExp.exec(src).toString();
			  
			   var arr:Array = exp.split("/");
			   
			   src = src.replace(exp,(Number(arr[0])/Number(arr[1])).toString());
			   
		   }
		   
		   
		   return src;
		}
		
		
		
		public static function replaceSubraction(src:String):String
		{
		
			
		     var rExp:RegExp = /-?[\d\.]+\s*\-\s*[\d\.]+/;
		     
		   
		   while(rExp.test(src))
		   {
			   var exp:String = rExp.exec(src).toString();
			   
			   
			   
			   var arr:Array = exp.split("-");
			   
			   switch(arr.length)
			   {
				   case 3:
					   src = src.replace(exp, (Number(arr[1]) + Number(arr[2])).toString());
					   src = "-" + src;
					   break;
				   case 2:
					   src = src.replace(exp,(Number(arr[0])-Number(arr[1])).toString());
					   break;
			   }
			   
			   
			   
		   }
		   
		   
		   return src;
		}
		
	

		
		public static function replaceMultiplication(src:String):String
		{
		
		 var rExp:RegExp = /-?[\d\.]+s*\*\s*[\d\.]+/;
		   
		   
		   while (rExp.test(src))
		   {
			   var exp:String = rExp.exec(src).toString();
			   
			   var arr:Array = exp.split("*");
			   
			   src = src.replace(exp,(Number(arr[0])*Number(arr[1])).toString());
			   
		   }
		   
		   
		   return src;
		}
		
		
		public static function replaceAddition(src:String):String
		{
		
		   var rExp:RegExp = /-?[\d\.]+s*\+\s*[\d\.]+/;
		   
		   
		   while (rExp.test(src))
		   {
			   var exp:String = rExp.exec(src).toString();
			  
			   var arr:Array = exp.split("+");
			   
			   src = src.replace(exp,(Number(arr[0])+Number(arr[1])).toString());
			   
		   }
		   
		   
		   return src;
		}
		
		
		
		
		
		
	}

}