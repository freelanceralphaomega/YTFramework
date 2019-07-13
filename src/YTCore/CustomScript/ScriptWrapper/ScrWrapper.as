package YTCore.CustomScript.ScriptWrapper 
{
	import YTCore.CustomScript.ScriptClassifier.LineScript;
	import YTCore.CustomScript.ScrScheduler;
	import YTCore.CustomScript.ScriptEvent;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ScrWrapper extends Sprite implements IRenderable 
	{
		
		private var canStep:Boolean = false;
		private var scrSch:ScrScheduler;
		private var actArr:Array;
		
		private var reg:Dictionary = new Dictionary();
		
		private var executionSch:Array;
		private var dispatchSc:Array;
		

		private var globalLineData:Object = new Object(); 
		private var actionQueue:Array = [];
		
		/**
		 * 
		 * @param	actionArr Array containing script of Line context 
		 */
		public function ScrWrapper(scrClass:Class,actionArr:Array,executionScht:Array,dispatchSct:Array)  
		{
			super();
			
			
			
			executionSch = executionScht;
			dispatchSc =dispatchSct ;
			
			actArr = actionArr;
			
			
			
			setup(scrClass); 
		}
		
		
		public function getActionInstance(id:String):IRenderable
		{
			return reg[id];
		}
		
		
		private function setup(sc:Class):void
		{
			
			for (var d:int = 0; d < actArr.length; d++)
			{
			
				var isLocal:Boolean = Boolean(actArr[d][1]);
				
				var ls = new sc(actArr[d][2], isLocal?null:globalLineData);
				addChild(ls);
				
				
				reg[actArr[d][0]] = ls;
				
				
				actionQueue.push(ls);
			
			}
			
			
			this.addEventListener(ScriptEvent.EXECUTE, executeCommand);
			
			scrSch = new ScrScheduler(this, dispatchSc, executionSch); 
			scrSch.start();
			
			
		}
		
		private function executeCommand(e:ScriptEvent):void 
		{
		
			reg[e.data.toString()].start();
		}
		
		
		public function step():void 
		{
			
			
			if (!canStep)
			return;
			
			
			scrSch.step();
			
			for (var d:int = 0; d < actionQueue.length; d++ )
			{
			
				actionQueue[d].step();
			}
			
			
			
		}
		
		public function stop():void 
		{
			canStep = false;
		}
		
		public function start():void 
		{
			canStep = true;
		}
		
	}

}