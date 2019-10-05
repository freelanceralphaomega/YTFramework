package YTCore.Components 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.ActionScheduler;
	import YTCore.Animators.Sequencer;
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import flash.display3D.IndexBuffer3D;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class PointConnector extends Sprite implements IRenderable
	{
		private var canStep:Boolean = false;
		
		private var wipeFlag:Boolean = false;
		
		private var ptArr:Array;
		private var col:uint;
		private var spd:Number; //Time per unit Lenghth
		private var lwid:Number;
		private var ewid:Number;
		private var isDotted:Boolean;
		
		
		private var timingArr:Array = [];
		private var currentTime:Number = 0;
		private var lengthArr:Array;
		private var edgeWidArr:Array;
		private var intervalLen:Array;
		private var mdoBleed:Boolean = false;
		private var mbleedTime:Number;
		
		private var minitA:Number;
		private var mendA:Number;
		
		private var segCount:int = 0; //Total number of micro segments that consists the curve
		
		private var widthArr:Array = [[.5,200]];
		
	
		
		private var segmentArr:Array = [];
		
		private var seq:Sequencer = new Sequencer();
		private var wipeSeq:Sequencer = new Sequencer();
		private var wipeSeqArr:Array = [];
		private var wipeT:Number;
		
		/**
		 * 
		 * @param	pa Array of points defining the path
		 * @param	cl Colour of the path
		 * @param	time Time required to draw the complete path
		 * @param	initWid Width of the path at the beginning
		 * @param   endWid Width of the path at the ending. If set to -1, initial Width is same as end width
		 * @param   widthControlArr [[pct_of_lenght, width], [pct_of_length, width].....]
		 * @param	dotted If the path is dotted
		 */
		public function PointConnector(pa:Array,cl:uint,time:Number,initWid:Number,endWid:Number=-1,widthControlArr:Array=null,doBleed:Boolean=false,bleedTime:Number=1,initA:Number=1,endA:Number=1,wipeTime:Number=2,dotted:Boolean=false) 
		{
			super();
			
			if (widthControlArr == null)
			widthArr = [];
			else
			widthArr = widthControlArr;
			
			if (endWid < 0)
			endWid = initWid;
			ptArr = pa;
			col = cl;
			spd = time;
			lwid = initWid;
			ewid = endWid;
			isDotted = dotted;
			mdoBleed = doBleed;
			mbleedTime = bleedTime;
			minitA = initA;
			mendA = endA;
			wipeT = wipeTime;
			
			
			extractLengthInfo();
			
			setup();
			setupWipeRoutine();
		}
		
		public function get POINTS():Array
		{
			return ptArr;
		}
		
		private function extractLengthInfo():void
		{
			var totalPathLen:Number = MathHandler.getTotalDistance(ptArr);
			
			lengthArr = [0];
			edgeWidArr = [lwid];
			
			for (var d:int = 0; d < widthArr.length; d++)
			{
				lengthArr.push(totalPathLen * widthArr[d][0]);
				edgeWidArr.push(widthArr[d][1]);
			}
			
			lengthArr.push(totalPathLen);
			edgeWidArr.push(ewid);
			intervalLen = Helper.getIntervalLength(lengthArr);
		}
		
		public function get totalAtomicSegment():int
		{
			return segCount;
		}
		
		
		public function setupWipeRoutine():void
		{
			var timePerUnitAtomicSegment:Number = wipeT / totalAtomicSegment;
			var delayArr:Array = [];
			var lastTimeStamp:Number = 0;
			
			for (var d:int = 0; d < segmentArr.length; d++ )
			{
				var dl:DLine = segmentArr[d];
				var wipeTime:Number = dl.segmentCount * timePerUnitAtomicSegment;
				var asch:ActionScheduler = new ActionScheduler(dl, "wipeFromHead", wipeTime);
				var timingArr:Array = [asch, lastTimeStamp];
				wipeSeqArr.push(timingArr);
				lastTimeStamp += wipeTime;
			}
			wipeSeq.initSequence(wipeSeqArr);
		}
	
		
		
		private function setup():void
		{
			var totalPathLen:Number = MathHandler.getTotalDistance(ptArr);
			
			var lengthCovered:Number = 0;
			
			
			
			var thicknessIncrementPerLen:Number = (lwid - ewid) / totalPathLen;
			var alphaIncrementPerLen:Number = (mendA-minitA)/totalPathLen;   
			
		
			
			var timePerUnitLen:Number = spd / totalPathLen;
			
			var lastWid:Number = lwid;
			var lastAlpha:Number = minitA;
			
			for (var d:int = 1; d < ptArr.length; d++ )
			{
				
				var dist:Number = MathHandler.getDistance(ptArr[d - 1], ptArr[d]);
				var cTime:Number = timePerUnitLen * dist;
				
				
				
				var intervalIndex:int = Helper.getRangeIndex(lengthArr, lengthCovered);
				
				var intvLen:Number = intervalLen[intervalIndex];
				
				thicknessIncrementPerLen = (edgeWidArr[intervalIndex+1]-edgeWidArr[intervalIndex]) / intvLen;
				
				timingArr.push(currentTime);
				
				currentTime+= cTime;
				
				var dline:DLine = new DLine(ptArr[d- 1], ptArr[d], col, cTime, lastWid, lastWid + dist * thicknessIncrementPerLen, mdoBleed, mbleedTime,lastAlpha,lastAlpha+dist*alphaIncrementPerLen,isDotted);
				lastWid = lastWid + dist * thicknessIncrementPerLen;
				lastAlpha = lastAlpha + dist * alphaIncrementPerLen;
				
				lengthCovered += dist;
				
				segmentArr.push(dline);
				addChild(dline);
				segCount += dline.segmentCount;
			}
			
		  
			
			var seqArr:Array = [];
			for (var k:int = 0; k < segmentArr.length; k++ )
			{
				//seq.addDependency(segmentArr[k], segmentArr[k + 1], YTEvent.FINISHED);
			
				
				seqArr.push([segmentArr[k], timingArr[k]]);
			}
			
		    seq.initSequence(seqArr);
			
			
		segmentArr[segmentArr.length - 1].addEventListener(YTEvent.FINISHED, onFin);
		}
		
		private function onFin(e:YTEvent):void 
		{
			canStep = false;
			segmentArr[segmentArr.length - 1].removeEventListener(YTEvent.FINISHED, onFin);
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			
		}
		
		
		public function step():void
		{
			if (!canStep)
			return;
			
			seq.step();
		}
		
		public function start():void
		{
			canStep = true;
		}
		
		public function stop():void
		{
			canStep = false;
		}
		
	}

}