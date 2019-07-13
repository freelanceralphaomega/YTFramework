package YTCore.CustomScript.ScriptClassifier 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DLine;
	import YTCore.Components.PointConnector;
	import YTCore.CustomScript.ScriptManager;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	
	 

	 
	public class PtConnectScript extends Sprite implements IRenderable 
	{
		
	 private var seq:Sequencer = new Sequencer();
	 private var commandString:String;
	 
	 
	 private var isLocal:Boolean = true;
	 
	 
	 private var dlineArr:Array = [];
	 
	 private var canStep:Boolean = false;
		
	 
	 private var lObj:Object;
	 private var gObj:Object;
	 
		public function PtConnectScript(command:String,globalOb:Object=null) 
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
			
			
			comm = comm.split("\r\n").join("");// .join("").split(" ").join("");
			
			
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
				var l:PointConnector;
				
				var ts:String = (commandSequence[k][0] as String).toUpperCase();
			
				ts =/\w+\d*/.exec(ts);
				
				
				
				switch(ts)
				{
                   
					
						case "MOVE":
					p = (commandSequence[k][1] as String).split(",");
					storageObject.currentPt = new Point(p[0],p[1]);
						break;
					
				
					case "PTARR":
						
						storageObject.pts = Helper.pointsFromArr(ScriptManager.stringToArray(commandSequence[k][1]));
						break;
						
						
					case "TIME":
					storageObject.time= Number(commandSequence[k][1]);
						break;
					
						
					
					case "ALPHA1":
						storageObject.alpha1 = Number(commandSequence[k][1]);
						break;
					
					case "ALPHA2":
						storageObject.alpha2 = Number(commandSequence[k][1]);
						break;
						
			
						
					case "TH1":
						storageObject.th1 = Number(commandSequence[k][1]);
						trace("PtConnectScriptx: ",storageObject.th1);
						break;
						
					case "TH2":
						storageObject.th2 = Number(commandSequence[k][1]);
							trace("PtConnectScriptx: ",storageObject.th2);
						break;
						
					case "CTRL":
						
						storageObject.ctrl = ScriptManager.stringToArray(commandSequence[k][1]);
						
						break;
						
						
					case "BL":
						var bb:String = (/\w+\d*/.exec(commandSequence[k][1]));
						
						storageObject.bl = bb == "true"?true:false;
					
						break;
						
						
					case "BT":
							
						storageObject.bt = Number(commandSequence[k][1]);
						break;
						
		            case "DOTTED":
						var dt:String = (/\w+\d*/.exec(commandSequence[k][1]));
						storageObject.dotted= dt == "true"?true:false;
						break;
						
					
					case "COL":
						storageObject.col = uint(commandSequence[k][1]);
						break;
						
						
					case "ROTATION":
						storageObject.rotation = Number(commandSequence[k][1]);
						break;
						
				}
				
			}
			
		
			
			
			
			l = new PointConnector(storageObject.pts, storageObject.col, storageObject.time, storageObject.th1, storageObject.th2, storageObject.ctrl, storageObject.bl, storageObject.bt, storageObject.alpha1, storageObject.alpha2, storageObject.dotted);		
			
			
			
			l.x = storageObject.currentPt.x;
			l.y = storageObject.currentPt.y;
			l.rotation = storageObject.rotation;
			
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