package YTCore.Utils 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.PointConnector;
	import YTCore.Events.YTEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class Helper 
	{
		
		public function Helper() 
		{
			
		}
		
		
		
		
		
		
		public static function sortStringArrByLength(s:Array):Array
		{

        for (var i:int=1 ;i<s.length; i++) 
        {
		
        var temp:String = s[i]; 
  
        // Insert s[j] at its correct position 
        var j:int = i - 1; 
        while (j >= 0 && temp.length > s[j].length) 
        { 
            s[j+1] = s[j]; 
            j--; 
        } 
        s[j+1] = temp; 
       } 
      return s;
		}
		
		/**
		 * 
		 * @param	src A string having format: param1:value1,param2:value2,param3:value3...
		 * @return
		 */
		public static function getObjectFromString(src:String):Object
		{
		
			var arr1:Array = src.split(",");
			var obj:Object = new Object();
			
			
			for (var d:int = 0; d < arr1.length; d++)
			{
				var arr2:Array = arr1[d].split(":");
				obj[arr2[0]] = arr2[1];
			}
			
			return obj;
		}
		
		public static function getDistanceInitEnd(polyArr:Array):Number
		{
			if (polyArr.length == 0)
			return 0;
			var init:Array = polyArr[0];
			var end:Array = polyArr[polyArr.length - 1];
			
			var xDist:Number = Math.abs(Number(init[0]) - Number(end[0]));
			var yDist:Number = Math.abs(Number(init[1]) - Number(end[1]));
			
			var xsq:Number = xDist * xDist;
			var ysq:Number = yDist * yDist;
			
			return Math.sqrt(xsq+ysq);
			
		}
		
		public static function pointsFromArr(arr:Array):Array
		{
			var retArr:Array = [];
			
			for (var d:int = 0; d < arr.length; d++ )
			{
				retArr.push(new Point(arr[d][0],arr[d][1]));
			}
			
			return retArr;
		}
		
		public static function arrayFromPoints(arr:Array):Array
		{
				var retArr:Array = [];
			
			for (var d:int = 0; d < arr.length; d++ )
			{
				retArr.push([arr[d].x,arr[d].y]);
			}
			
			return retArr;
		}
		
		public static function addConsecutiveDependency(seq:Sequencer,arr:Array,timePerUnitLen:Number):void
		{
			var playHeadTime:Number = 0;
			var seqArr:Array = [];
			for (var d:int = 0; d < arr.length; d++ )
			{
				var m:int = 0;// 
				if (d > 0)
				m =timePerUnitLen * MathHandler.getTotalDistance((arr[d - 1]as PointConnector).POINTS) ;
				
				seqArr.push([arr[d], playHeadTime+m]);
				playHeadTime += m;
			}
			
			seq.initSequence(seqArr);
			
		}
		
		/**
		 * 
		 * @param	seq Sequencer
		 * @param	arr Array of IRenderable
		 */
		public static function drawParallelLineDrawing(seq:Sequencer,arr:Array):void
		{
			seq.register(arr);
			
			for (var d:int = 0; d < arr.length; d++ )
			{
				
				seq.initSequence([[arr[d],0]]);
				
			}
			
			
		}
		
		
		public static function addBackToBackDependency(seq:Sequencer,arr:Array):void
		{
			if(arr.length>1)
			seq.register(arr);
			
			
			for (var d:int = 0; d < arr.length-1; d++ )
			{
				
				seq.addDependency(arr[d],arr[d+1],YTEvent.FINISHED);
				
			}
			
			seq.initSequence([[arr[0],0]]);
		}
		
		public static function getRangeIndex(arr:Array,testNum:Number):int
		{
			var ret:int = -1;
			
			for (var d:int = 0; d < arr.length-1; d++)
			{
				if (testNum >= arr[d] && testNum <= arr[d + 1])
				return d;
			}
			return ret;
		}
		
		public static function getIntervalLength(arr:Array):Array
		{
			var retArr:Array = [];
			for (var d:int = 0; d < arr.length-1; d++ )
			{
				retArr.push(arr[d+1]-arr[d]);
			}
			return retArr;
		}
		
		/**
		 * 
		 * @param	str string reperesentation of target array of lineArt, e.g: [[[],[],[],[]...[]],[[],[],[]....[]]]
		 * @return  array represented by the input string
		 */
		public static function getArrayFromStringEquivalent(str:String):Array
		{
			var retArr:Array = [];
			var arr1:Array = [];
	
			
			arr1 = str.split("]],");
			
			for (var d:int = 0; d < arr1.length; d++)
			{
				
				var trueArr:Array = [];
				var rawArr:Array = [];
				var dstr:String = arr1[d];
				var dreg:RegExp = /\s*\-?[\d\.]+\s*,\s*\-?[\d\.]+\s*/g;
				
				var ss:Object = dreg.exec(dstr);
				
				while (ss != null)
				{
					rawArr.push(ss);
					ss = dreg.exec(dstr);
				}
				
				for (var m:int = 0; m < rawArr.length; m++)
				{
					var mexp:RegExp =/\-?[\d\.]+/;
					var mstr:String = rawArr[m];
					var dA:Array = mstr.split(",");
					var num1:Number = Number(mexp.exec(dA[0]));
					var num2:Number = Number(mexp.exec(dA[1]));
					
					if (isNaN(mexp.exec(dA[0])) || isNaN(mexp.exec(dA[1])))
					trace("Helper: isNaN: ",m);
					
					var pArr:Array = [num1, num2];
					trueArr.push(pArr);
				}
				
				retArr.push(trueArr);
				
			}
			
			
			
			return retArr;
		}
		
		
		/**
		 * @param lA Line Art Array
		 * @return coordinates of the bounding rectange of any line Art, starting from upper left and clockwise
		 */
		public static function getLineArtBoundingRectangle(lA:Array):Array
		{
			var retArr:Array = [];
			var maxValX:Number = 0;
			var maxValY:Number = 0;
			var minValX:Number = 0;
			var minValY:Number = 0;
			
			for (var d:int = 0; d < lA.length; d++)
			{
				for (var k:int = 0; k < lA[d].length; k++ )
				{
					if (maxValX < lA[d][k][0])
					maxValX = lA[d][k][0];
					
					if (maxValY < lA[d][k][1])
					maxValY = lA[d][k][1];
					
					if (minValX > lA[d][k][0])
					minValX = lA[d][k][0];
					
					if (minValY > lA[d][k][1])
					minValY = lA[d][k][1];
					
				}
			}
			
			retArr.push(new Point(minValX, minValY), new Point(maxValX, minValY), new Point(maxValX, maxValY), new Point(minValX, maxValY));
			
			return retArr;
			
		}
		
	}

}