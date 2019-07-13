package YTCore.Abstract.Math 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class PatternGenerators 
	{
		
		public function PatternGenerators() 
		{
			
		}
		
		public static function pattern_P1(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				var y:Number = -Math.exp(Math.cos(MathHandler.degToRad(currentX))); 
				retVal.push(new Point(currentX, y));
				currentX += res;
			}
			
			
			return retVal;
		}
		
		public static function pattern_P2(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				var y:Number = -Math.cos(Math.cos(MathHandler.degToRad(currentX))*MathHandler.degToRad(currentX)); 
				retVal.push(new Point(currentX, y));
				currentX += res;
			}
			
			
			return retVal;
		}
		
			public static function pattern_P3(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				var y:Number = -Math.cos(MathHandler.degToRad(currentX))*Math.sin(MathHandler.degToRad(2*currentX))*Math.cos(MathHandler.degToRad(3*currentX))*Math.cos(MathHandler.degToRad(4*currentX)); 
				retVal.push(new Point(currentX, y));
				currentX += res;
			}
			
			
			return retVal;
		}
		
	}

}