package YTCore.Abstract.Math.COMMON 
{
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class MathFunction 
	{
		
		public function MathFunction() 
		{
			
		}
		
		public static function sin(val:Number):Number
		{
			return Math.sin(val);
		}
		
		public static function cos(val:Number):Number
		{
			return Math.cos(val);
		}
		
		public static function tan(val:Number):Number
		{
			return Math.tan(val);
		}
		
		public static function identity(val:Number):Number
		{
			return val;
		}
		
		public static function quadratic(val:Number):Number
		{
			return val * val;
		}
		
		/**
		 * @exception This only works for strictly monotonic function
		 * @param	a   Initial value of the function (We need Inverse function to calculate the argument)
		 * @param	b   Final value of the function (We need Inverse function to calculate the argument)
		 * @param	numVal How many values should be included in 
		 * @param	Fn
		 * @param	FnInv
		 * @return
		 */
		public static function getFunctionValuesBetween(a:Number,b:Number,numVal:int,Fn:Function,FnInv:Function,fnAdditionalArgs:Array,FnInvAdditionalArgs:Array):Array
		{
			
			
			var retArr:Array = [];
			
			var f_init:Number = FnInv(a, FnInvAdditionalArgs);
			var f_final:Number = FnInv(b, FnInvAdditionalArgs);
			
			
			
			var asc:Boolean = true;
			if (f_final - f_init < 0)
			asc = false;
			
			var currentVal:Number = f_init;
			
			var step:Number = (f_final - f_init) / (numVal-1);
			
			
			if (asc == true)
			{
			while (currentVal <f_final)
			{
				retArr.push(Fn(currentVal,fnAdditionalArgs));
				currentVal += step;
			}
			}
			else
			{
				while (currentVal > f_final)
			{
				retArr.push(Fn(currentVal,fnAdditionalArgs));
				currentVal += step;
			}
			}
			
			retArr.push(b);
			
			return retArr;
		}
		
		
	}

}