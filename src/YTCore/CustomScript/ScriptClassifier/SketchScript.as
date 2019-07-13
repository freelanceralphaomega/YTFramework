package YTCore.CustomScript.ScriptClassifier 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DLine;
	import YTCore.Components.DSketch;
	import YTCore.Components.GraphPaper;
	import YTCore.Components.Templates.LineArt;
	import YTCore.CustomScript.ScriptManager;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	
	 

	 
	public class SketchScript extends Sprite implements IRenderable 
	{
		
	 private var seq:Sequencer = new Sequencer();
	 private var commandString:String;
	 
	 
	 private var isLocal:Boolean = true;
	 
	 
	 private var dlineArr:Array = [];
	 
	 private var canStep:Boolean = false;
		
	 
	 private var lObj:Object;
	 private var gObj:Object;
	 
		public function SketchScript(command:String,globalOb:Object=null) 
		{
			super();
			
		
			
			lObj = new Object();
			gObj = globalOb;
			
			setup();
			
			execute(command);
			
		}
		
		private function setup():void
		{
			storageObject.width               =  500 ;
			storageObject.height              =  500 ;

		}
		
		
		public function setLocalFlag():void
		{
			isLocal = true;
		}
		
		public function setGlobalFlag():void
		{
			isLocal = false;
		}
		
		public function get storageObject():Object
		{
			if (isLocal)
			return lObj;
			
			return gObj;
		}
		
		public function execute(comm:String):void
		{
			
			
			var dlArr:Array = [];
			
			var commandSequence:Array = [];
			
			
			comm = comm.split("\r\n").join("").split(" ").join("");
			
			
			var commandSegment:Array = comm.split(";");
			
			for (var d:int = 0; d < commandSegment.length; d++ )
			{
				var command:Array = (commandSegment[d] as String).split(":");
				commandSequence.push(command);
				
			}
			
		
			
			
			for (var k:int = 0; k < commandSequence.length; k++)
			{
				
				var p:Array;
				var l:DSketch;
				
				var ts:String = (commandSequence[k][0] as String).toUpperCase();
				
				
				switch(ts)
				{

					case "MOVE":
						
					p = (commandSequence[k][1] as String).split(",");
					storageObject.currentPt = new Point(p[0],p[1]);
						
						break;
						
						
					case "BORDER_WIDTH":
					storageObject.bwidth= Number(commandSequence[k][1]);
						break;
					case "BORDER_COLOR":
					storageObject.bcol= uint(commandSequence[k][1]);
						break;
						
					case "DRAWTIME":
					storageObject.drawtime= Number(commandSequence[k][1]);
						break;
						
					case "PREDEFINED_SHAPE":
					storageObject.pdshape= commandSequence[k][1];
						break;
						
					case "SHAPE_COLOR":
						var st:String = commandSequence[k][1];
						var ar:Array = ScriptManager.stringToArray(st);
						storageObject.colors = ar;
						break;
						
					case "SHAPE_ALPHA":
						var st2:String = commandSequence[k][1];
						var ar2:Array = ScriptManager.stringToArray(st2);
						storageObject.alpha = ar2;
						break;
						
					case "SHAPE":
						var r:Array = [];
						var s:String = commandSequence[k][1];
						
						
						var arr:Array = s.split("|");
						for (d = 0; d < arr.length; d++ )
						{
							r.push(ScriptManager.stringToArray(arr[d]));
						}
						
						
						trace(r[0]);
						trace(r[1]);
						
						storageObject.shape = r;
						
						break;
			
				}
				
			}
			
			
			if(!storageObject.pdshape)	
			l = new DSketch(storageObject.shape,storageObject.bcol ,storageObject.drawtime,storageObject.colors,storageObject.alpha,[],!true,storageObject.bwidth);
			else
			{
			try
			{
			l = new DSketch(LineArt[storageObject.pdshape],storageObject.bcol ,storageObject.drawtime,storageObject.colors,storageObject.alpha,[],!true,storageObject.bwidth);
			}
			catch (e:Error)
			{
				l = new DSketch(Helper.getArrayFromStringEquivalent(FileLoader.readShape(storageObject.pdshape)),storageObject.bcol ,storageObject.drawtime,storageObject.colors,storageObject.alpha,[],!true,storageObject.bwidth);
			}
			}
			
			try{
			l.x = storageObject.currentPt.x;
			l.y = storageObject.currentPt.y;
			}catch(e:Error){}
			
			addChild(l);
			        if(storageObject.rotation)
					l.rotation = Number(storageObject.rotation);
					dlArr.push(l);
			
			Helper.addBackToBackDependency(seq, dlArr);
		
			
			dlArr[dlArr.length - 1].addEventListener(YTEvent.FINISHED, onfin); 
			
		}
		
		private function onfin(e:YTEvent):void 
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			stop();
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			
			
			seq.step();
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