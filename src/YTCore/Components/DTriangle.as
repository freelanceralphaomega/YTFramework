package YTCore.Components 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DLine;
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class DTriangle extends Sprite implements IRenderable
	{
		private var seq:Sequencer = new Sequencer();
		private var aLine:DLine = new DLine();
		private var aLine2:DLine = new DLine();
		private var aLine3:DLine = new DLine();
		private var canStep:Boolean = false;
		private var ptArr:Array;
		private var cols:Array;
		
		/**
		 * 
		 * @param	pts array of 3 points [new point(x1,y1),new point(x2,y2),new point(x3,y3)]
		 */
		public function DTriangle(pts:Array,colArr:Array=null) 
		{
			super();
			
			ptArr = pts;
			if(colArr!=null)
			cols = colArr;
			else
			cols = [0xFFFFFF,0xFFFFFF,0xFFFFFF];
			this.addEventListener(Event.ADDED_TO_STAGE, onStg);
		}
		
		private function setup():void
		{
			addChild(aLine);
			addChild(aLine2);
			addChild(aLine3);
			
			aLine.drawLine(ptArr[0], ptArr[1], cols[0], 5, 1,false);
			aLine2.drawLine(ptArr[1], ptArr[2], cols[1], 5, 1,false);
			aLine3.drawLine(ptArr[2], ptArr[0], cols[2],5,1,false);
			
			seq.register([aLine2,aLine3]);
			seq.initSequence([[aLine, 0]]);
			seq.addDependency(aLine, aLine2, YTEvent.FINISHED);
			seq.addDependency(aLine2, aLine3, YTEvent.FINISHED);
			
			aLine3.addEventListener(YTEvent.FINISHED, onFin);
		}
		
		private function onFin(e:YTEvent):void 
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			setup();
		}
		
		public function step():void 
		{
			if(canStep)
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