package YTCore.Abstract.Math.COMMON 
{
	import YTCore.Utils.Helper;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class MathHandler 
	{
		
		public function MathHandler() 
		{
			
		}
		
		
		
		public static function getStraightLine(initX:Number,endX:Number,slope:Number,C:Number,res:Number=.1):Array
		{
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -slope*currentX+C));
				currentX += res;
			}
			
			
			return retVal;
		}
		
		/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial value in unit to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return
		 */
		public static function getSinPtArr(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -Math.sin(MathHandler.degToRad(currentX))));
				currentX += res;
			}
			
			
			return retVal;
		}
		
		
					/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial point to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return
		 */
		public static function getExpsinArr(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				var y:Number = -Math.cos(MathHandler.degToRad(currentX));
				retVal.push(new Point(currentX, y));
				currentX += res;
			}
			
			
			return retVal;
		}
		
		
			/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial point to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return
		 */
		public static function getCosPtArr(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -Math.cos(MathHandler.degToRad(currentX))));
				currentX += res;
			}
			
			
			return retVal;
		}
		
			/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial point to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return
		 */
	public static function getTanPtArr(initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -Math.tan(MathHandler.degToRad(currentX))));
				currentX += res;
			}
			
			
			return retVal;
		}
		
			/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial point to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return
		 */
	public static function getArcSinPtArr(pixelsPerUnitX:Number,pixelsPerUnitY:Number,initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -MathHandler.degToRad(Math.asin(currentX))));
				currentX += res;
			}
			
			
			return retVal;
		}
		
					/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial point to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return
		 */
		public static function getArcCosPtArr(pixelsPerUnitX:Number,pixelsPerUnitY:Number,initX:Number,endX:Number,res:Number=.1):Array
		{
			
			var unitPerPixelX:Number = 1 / pixelsPerUnitX;
			var unitPerPixelY:Number = 1 / pixelsPerUnitY;
			
			initX = initX * pixelsPerUnitX;
			endX = endX * pixelsPerUnitX;
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -MathHandler.degToRad(Math.acos(currentX))));
				currentX += res;
			}
			
			
			return retVal;
		}
		
						/**
		 * 
		 * @param	pixelsPerUnitX How many pixels to represent 1 unit along X axis
		 * @param	pixelsPerUnitY How many pixels to represent 1 unit along Y axis
		 * @param	initX Initial point to start drawing the graph
		 * @param	endX End point of graph
		 * @param	res step along X axis for drawing the graph
		 * @return  
		 */
		public static function getArcTantArr(pixelsPerUnitX:Number,pixelsPerUnitY:Number,initX:Number,endX:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				retVal.push(new Point(currentX, -MathHandler.radToDeg(Math.atan(currentX))));
				currentX += res;
			}
			
			
			return retVal;
		}
		
		
		
		public static function getEllipsePtArr(initX:Number,endX:Number,a:Number,b:Number,c:Number,res:Number=.1):Array
		{
			
			
			
			var retVal:Array = [];
			var currentX:Number = initX;
			while (currentX <= endX)
			{
				var X:Number = currentX;
				X = X * X;
				var y:Number = -Math.sqrt((c-a*X)/b);
				retVal.push(new Point(currentX, y));
				currentX += res;
			}
			
			
			return retVal;
		}
		
		
		
	
		/**
		 * 
		 * @param	ptArr array Containing all points in the path
		 * @return Total distance of the path
		 */
		public static function getTotalDistance(ptArr:Array):Number
		{
			var dist:Number = 0;
			
			for (var d:int = 1; d < ptArr.length; d++)
			{
				dist += getDistance(ptArr[d],ptArr[d-1]);
			}
			return dist;
		}
		
		
		public static function getDistanceOfLineArt(lineArtArr:Array):Number
		{
			var dist:Number = 0;
			
			
			
			for (var d:int = 1; d < lineArtArr.length; d++)
			{
				dist += getTotalDistance(Helper.pointsFromArr(lineArtArr[d]));
			}
			return dist;
			
		}
		
		public static function getDistance(pt1:Point,pt2:Point):Number
		{
			var dx:Number = pt1.x - pt2.x;
			var dy:Number = pt1.y - pt2.y;
			
			var distSq:Number = dx * dx + dy * dy;
			
			var retVal:Number = Math.sqrt(distSq);
			
			return retVal;
			
		}
		
		
		public static function unitToPixelCoordinate(ptArr:Array,pixelPerUnitX:Number,pixelPerUnitY:Number):Array
		{
			
			var retArr:Array = [];
			for (var d:int = 0; d < ptArr.length; d++)
			{
				var unitX:Number = pixelPerUnitX * ptArr[d].x;
				var unitY:Number = pixelPerUnitY * ptArr[d].y;
				retArr.push(new Point(unitX,unitY));
			}
			
			return retArr;
		}
		
		
		public static function degToRad(deg:Number):Number
		{
			return(deg*(Math.PI/180));
		}
		
		public static function radToDeg(rad:Number):Number
		{
			return(rad*(180/Math.PI));
		}
		
		
		public static function getMappedValues(input:Array,fn:Function):Array
		{
			var output:Array = [];
			
			for (var d:int = 0; d < input.length; d++ )
			{
				output.push(fn(input[d]));
			}
			
			return output;
		}
		
		public static function getContinuousMappedValues(init:Number,end:Number,step:Number,fn:Function):Array
		{
			var output:Array = [];
		
			var val:Number = init;
			
			while (val <= end)
			{
				output.push(fn(val));
				val += step;
			}
			
			return output;
		 
		}
		
		public static function getNearestInteger(val:Number):int
		{
			if (val - Math.floor(val) > .5)
			return Math.floor(val) + 1;
			
			return Math.floor(val);
		}
		
		/**
		 * @param	ptArr
		 * @param	refX
		 * @param	refY
		 * @return
		 */
		public static function shiftRefPoint(ptArr:Array,refX:Number,refY:Number):Array
		{
			var retArr:Array = [];
			
			var shiftX:Number = ptArr[0].x - refX;
			var shiftY:Number = ptArr[0].y - refY;
			
			for (var d:int = 0; d < ptArr.length; d++)
			{
				retArr.push(new Point(ptArr[d].x-shiftX,ptArr[d].y-shiftY));
			}
			
			return retArr;
		}
		
	}

}