package YTCore.Abstract.Math.COMMON 
{
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class UtilMathFunction 
	{
		
		public function UtilMathFunction() 
		{
			
		}
		
		/**
		 * @usage Expression: ax+b
		 * @param	x
		 * @param	ab
		 * @return value of ax+b
		 */
		public static function LINEAR(x:Number,ab:Array):Number
		{
			
			return(Number(ab[0])*x+Number(ab[1]));
		}
		
		public static function LINEAR_INV(n:Number,ab:Array):Number
		{
			
			return((n-Number(ab[1]))/Number(ab[0]));
		}
		
	   /**
	    * 
	    * @param	x   value of the free variable
	    * @param	abc co-efficent array of the expression ax^2+bx+c
	    * @return   value of the function at the given point
	    */
		public static function QUADRATIC(x:Number,abc:Array):Array
		{
			return([Number(abc[0])*x*x+Number(abc[1])*x+Number(abc[2]),0]);
		}
		
		/**
		 * @usage Solution of a quadratic equation for x, ax^2+bx+c=n
		 * @param	n ax^2+bx+c=n
		 * @param	abc [a,b,c]
		 * @return  
		 */
		public static function QUADRATIC_INV_1(n:Number,abc:Array):Array
		{
			var retArr:Array = [];
			var k:Number = 0;
			var D:Number = Number(abc[1]) * Number(abc[1]) - 4 * Number(abc[0]) * (Number(abc[2]) - n);
			if (D < 0)
			k = 1;
			
			if (D < 0)
			D =-D;
			
			var sqRt:Number = Math.sqrt(D);
			
			var real1:Number;
			var complex1:Number;
			
			var real2:Number;
			var complex2:Number;
			
			if (k == 0)
			{
				real1 = ( -Number(abc[1]) + sqRt) / (2 * Number(abc[0]));
				complex1 = 0;
				
				real2 = ( -Number(abc[1]) - sqRt) / (2 * Number(abc[0]));
				complex2 = 0;
			}
			
			if (k == 1)
			{
				real1 =  -Number(abc[1]) / (2 * Number(abc[0]));
				complex1 = sqRt / (2 * Number(abc[0]));
				
				real2 = real1;
				complex2 = -complex1;
			}
			
			retArr.push([real1,complex1],[real2,complex2],k);
			
			return retArr;
		}
		
		/**
		 * @usage Expression: ax^2
		 * @param	x
		 * @param	arg array containing coefficient a [a]
		 */
		public static function AX2(x:Number,arg:Array):Number
		{
			return(Number(arg[0])*x*x);
		}
		
		public static function AX2_INV(n:Number, arg:Array):Number
		{
			return(Math.sqrt(n/Number(arg[0])));
		}
		
		/**
		 * @usage expression: ax^n
		 * @param	x
		 * @param	arg [a,n]
		 * @return value of ax^n
		 */
		public static function AXn(x:Number, arg:Array):Number
		{
			return(Number(arg[0])*Math.pow(x,Number(arg[1])));
		}
		
		public static function AXn_INV(n:Number,arg:Array):Number
		{
			return(Math.pow(n/Number(arg[0]),1/Number(arg[1])));
		}
		
		
		/**
		 * @usage Expression: a*e^x
		 * @param	x
		 * @param	arg [a]
		 */
		public static function A_EXP_X(x:Number,arg:Array):Number
		{
			return(Number(arg[0]) * Math.exp(x));
		}
		
		public static function A_EXP_X_INV(n:Number,arg:Array):Number
		{
			return(Math.log(n/Number(arg[0])));
		}
		
	}

}