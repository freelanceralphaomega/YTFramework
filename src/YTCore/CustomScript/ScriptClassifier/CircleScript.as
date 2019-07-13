package YTCore.CustomScript.ScriptClassifier 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DLine;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	
	 

	 
	public class CircleScript extends Sprite implements IRenderable 
	{
		
	 private var seq:Sequencer = new Sequencer();
	 private var commandString:String;
	 
	 
	 private var isLocal:Boolean = true;
	 
	 
	 private var dlineArr:Array = [];
	 
	 private var canStep:Boolean = false;
		
	 
	 private var lObj:Object;
	 private var gObj:Object;
	 
		public function CircleScript(command:String,globalOb:Object=null) 
		{
			super();
			
		
			
			lObj = new Object();
			gObj = globalOb;
			
			setup();
			
			execute(command);
			
		}
		
		private function setup():void
		{
			var obj:Object = storageObject;
			
			
	         obj.currentPt=new Point(0,0);
	         obj.currentCol=0xABCDEF;
	         obj.time = 1;
	         obj.thickness=2;
	         obj.alpha = 1;
			 obj.angle = 360;
			 obj.dir = 1;
	       
	      
			
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
			
		
			
			// var ptCon:DLine = new DLine(new Point(0, 0), new Point(400, 0), 0xCC0000, 2, 10, 10, true, 1, 0, 1);
			// addChild(ptCon);
			 
			// dlArr.push(ptCon);
			
			for (var k:int = 0; k < commandSequence.length; k++)
			{
				
				var p:Array;
				var l:DCircleSegment;
				
				var ts:String = (commandSequence[k][0] as String).toUpperCase();
				
				
				
				switch(ts)
				{

					case "MOVE":
						
					p = (commandSequence[k][1] as String).split(",");
					storageObject.currentPt = new Point(p[0],p[1]);
						
						break;
						
						
					case "TIME":
					storageObject.time= Number(commandSequence[k][1]);
						break;
					
						
					
					case "ALPHA":
						storageObject.alpha = Number(commandSequence[k][1]);
						break;
						
			
					
						
					case "TH":
						storageObject.thickness = Number(commandSequence[k][1]);
						break;
						
		
						
					case "OFFSET":
						p = (commandSequence[k][1] as String).split(",");
						storageObject.currentPt = new Point(Point(storageObject.currentPt).x+Number(p[0]),Point(storageObject.currentPt).y+Number(p[1]));
						break;
					
					case "COL":
						storageObject.currentCol = uint(commandSequence[k][1]);
						break;
						
					case "RADIUS":
						
						storageObject.radius = Number(commandSequence[k][1]);
						break;
						
					case "ROTATION":
						storageObject.rotation = Number(commandSequence[k][1]);
						break;
						
					case "ANG":
						storageObject.angle = Number(commandSequence[k][1]);
						
						break;
				}
				
			}
			
			
					
			l = new DCircleSegment(storageObject.angle, storageObject.radius, storageObject.currentCol, storageObject.time, storageObject.thickness,storageObject.dir);
			
			
			l.x = storageObject.currentPt.x;
			l.y = storageObject.currentPt.y;
			
			addChild(l);
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