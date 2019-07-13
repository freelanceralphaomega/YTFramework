package YTCore.CustomScript.ScriptClassifier 
{
	import YTCore.Animators.Sequencer;
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
	
	 

	 
	public class LineScript extends Sprite implements IRenderable 
	{
		
	 private var seq:Sequencer = new Sequencer();
	 private var commandString:String;
	 
	 
	 private var isLocal:Boolean = true;
	 
	 
	 private var dlineArr:Array = [];
	 
	 private var canStep:Boolean = false;
		
	 
	 private var lObj:Object;
	 private var gObj:Object;
	 
		public function LineScript(command:String,globalOb:Object=null) 
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
	         obj.currentCol=0x000000;
	         obj.speedPerUnitLength = 2 / 400;
	         obj.initThickness=2;
	         obj.endThickness= 2;
	         obj.doBleed= true;
	         obj.initAlpha= 1;
	         obj.endAlpha= 1;
	         obj.bleedTime = 1; 
			
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
				var l:DLine;
				switch((commandSequence[k][0] as String).toUpperCase())
				{
					case "MOVE":
						
					p = (commandSequence[k][1] as String).split(",");
					storageObject.currentPt = new Point(p[0],p[1]);
						
						break;
						
						
					case "SP":
					p = (commandSequence[k][1] as String).split(",");
					storageObject.speedPerUnitLength= (Number(p[1])/Number(p[0]));
						break;
					
						
					case "BL":
						storageObject.doBleed = commandSequence[k][1] as Boolean;
						break;
					
					case "ALPHA1":
						storageObject.initAlpha = Number(commandSequence[k][1]);
						break;
						
					case "ALPHA2":
						storageObject.endAlpha = Number(commandSequence[k][1]);
						break;
						
					case "BT":
						storageObject.bleedTime = Number(commandSequence[k][1]);
						break;
						
					case "TH1":
						storageObject.initThickness = Number(commandSequence[k][1]);
						break;
						
					case "TH2":
						storageObject.endThickness = Number(commandSequence[k][1]);
						break;
						
					case "OFFSET":
						p = (commandSequence[k][1] as String).split(",");
						storageObject.currentPt = new Point(Point(storageObject.currentPt).x+Number(p[0]),Point(storageObject.currentPt).y+Number(p[1]));
						break;
					
					case "COL":
						storageObject.currentCol = uint(commandSequence[k][1]);   
						break;
						
						
					case "U":
						
					var u:Number = commandSequence[k][1];
					l = new DLine(Point(storageObject.currentPt),new Point(Point(storageObject.currentPt).x,Point(storageObject.currentPt).y-u),uint(storageObject.currentCol),u*Number(storageObject.speedPerUnitLength),Number(storageObject.initThickness),Number(storageObject.endThickness),Boolean(storageObject.doBleed),Number(storageObject.bleedTime),Number(storageObject.initAlpha),Number(storageObject.endAlpha));
				    storageObject.currentPt = new Point(Point(storageObject.currentPt).x,Point(storageObject.currentPt).y-u);
					addChild(l);
					
					dlArr.push(l);
						
						break;
						
						
					case "D":
						
					var dn:Number = commandSequence[k][1];
					l = new DLine(Point(storageObject.currentPt),new Point(Point(storageObject.currentPt).x,Point(storageObject.currentPt).y+dn),Number(storageObject.currentCol),dn*Number(storageObject.speedPerUnitLength),Number(storageObject.initThickness),Number(storageObject.endThickness),Boolean(storageObject.doBleed),Number(storageObject.bleedTime),Number(storageObject.initAlpha),Number(storageObject.endAlpha));
				    storageObject.currentPt = new Point(storageObject.currentPt.x,storageObject.currentPt.y+dn);
					addChild(l);
					dlArr.push(l);
						break;
						
						
					case "L":
						var left:Number = commandSequence[k][1];
					l = new DLine(Point(storageObject.currentPt),new Point(Point(storageObject.currentPt).x-left,Point(storageObject.currentPt).y),Number(storageObject.currentCol),left*Number(storageObject.speedPerUnitLength),Number(storageObject.initThickness),Number(storageObject.endThickness),Boolean(storageObject.doBleed),Number(storageObject.bleedTime),Number(storageObject.initAlpha),Number(storageObject.endAlpha));
				    storageObject.currentPt = new Point(Point(storageObject.currentPt).x-left,Point(storageObject.currentPt).y);
					addChild(l);
					
					dlArr.push(l);
						
						break;
						
						
					case "R":
						
						trace(Point(storageObject.currentPt));
						
						var right:Number = Number(commandSequence[k][1]);
					
					l = new DLine(Point(storageObject.currentPt),new Point(Point(storageObject.currentPt).x+right,Point(storageObject.currentPt).y),Number(storageObject.currentCol),right*Number(storageObject.speedPerUnitLength),Number(storageObject.initThickness),Number(storageObject.endThickness),Boolean(storageObject.doBleed),Number(storageObject.bleedTime),Number(storageObject.initAlpha),Number(storageObject.endAlpha));
					
				    storageObject.currentPt = new Point(Point(storageObject.currentPt).x+right,Point(storageObject.currentPt).y);
					addChild(l);
					
					dlArr.push(l);
						
						break;
				}
				
			
			}
			
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