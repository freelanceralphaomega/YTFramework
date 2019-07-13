package YTCore.CustomScript.ScriptClassifier 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DLine;
	import YTCore.Components.PointConnector;
	import YTCore.Components.Templates.Alphabet.Font2;
	import YTCore.Components.Text.DAlphabets.DText;
	import YTCore.Components.Text.RunningText;
	import YTCore.Components.Text.WavyText;
	import YTCore.CustomScript.ScriptManager;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	
	/**
	 * ...
	 * @author ...
	 */
	
	 

	 
	public class TextScript extends Sprite implements IRenderable 
	{
		
	 private var seq:Sequencer = new Sequencer();
	 private var commandString:String;
	 
	 
	 private var isLocal:Boolean = true;
	 
	 
	 private var dlineArr:Array = [];
	 
	 private var canStep:Boolean = false;
		
	 
	 private var lObj:Object;
	 private var gObj:Object;
	 
		public function TextScript(command:String,globalOb:Object=null) 
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
			
			storageObject.lcol = 0xCCCCCC;
			storageObject.fillAlpha = 1;
			storageObject.alpha = 1;
			storageObject.time = 4;
			storageObject.wspace = 1;
			
			storageObject.fillcolor = 0xABCDEF;
			
	     
	       
	      
			
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
				var l:IRenderable;
				
				var ts:String = (commandSequence[k][0] as String).toUpperCase();
				
			
				ts =/\w+\d*/.exec(ts);
				
				
				
				switch(ts)
				{
                   
					
					case "MOVE":
					p = (commandSequence[k][1] as String).split(",");
					storageObject.currentPt = new Point(p[0],p[1]);
						break;
					
						
					
					case "ALPHA":
						storageObject.alpha = Number(commandSequence[k][1]);
						break;
					
			        case "FONT":
						storageObject.font = commandSequence[k][1];
						break;
						
				     case "SIZE":
						 storageObject.size = Number(commandSequence[k][1]);
						 break;
						 
					 case "COLORS":
						 storageObject.colors = ScriptManager.stringToArray(commandSequence[k][1]);
						
						 break;
						 
					 case "WAVESCALE":
						 storageObject.waveScale = Number(commandSequence[k][1]);
						 break;
						 
				     case "WORDSPACE":
						 storageObject.wspace = Number(commandSequence[k][1]);
						 break;
					
					case "ISBITMAP":
						var isbitmap:String = (/\w+\d*/.exec(commandSequence[k][1]));
						storageObject.isBitmap = isbitmap == "true"?true:false;
						break; 
						 
					case "TEXT":
						 storageObject.text = commandSequence[k][1];
						break;
						
					 case "TIME":
						 storageObject.time = Number(commandSequence[k][1]);
						
						 break;
						 
					case "LINE_COLOR":
						 storageObject.lcol = Number(commandSequence[k][1]);
						break;
						
						
				   case "FILL_ALPHA":
					   storageObject.fillAlpha=Number(commandSequence[k][1]);
					   break;
				   
				   case "FILL_COLOR":
					   storageObject.fillcolor=Number(commandSequence[k][1]);
					   break;
				   
						
					case "STYLE":
						
						var tstyle:String = (/\w+\d*/.exec(commandSequence[k][1]));
						
						switch(tstyle.toUpperCase())
						{
							case "WRITEON":
								//l = new RunningText(storageObject.text, storageObject.font, storageObject.size, storageObject.colors, storageObject.time, storageObject.isBitmap);
								l=new RunningText(storageObject.text, storageObject.font,storageObject.size, storageObject.colors, storageObject.time, false);
								break;
							case "WAVY":
								l = new WavyText(storageObject.text, storageObject.font, storageObject.size, storageObject.colors, storageObject.time,storageObject.waveScale, storageObject.isBitmap);
								break;
							case "DTEXT":
								l = new DText(Font2, (storageObject.text as String).toUpperCase(), storageObject.lcol, storageObject.fillcolor, storageObject.fillAlpha, null,storageObject.time,storageObject.wspace);
								
								(l as DisplayObject).scaleX = (l as DisplayObject).scaleY = .02 * storageObject.size;
								
								break;
								
						}
						
						
						break;
					
					case "COL":
						storageObject.col = uint(commandSequence[k][1]);
						break;
						
						
					case "ROTATION":
						storageObject.rotation = Number(commandSequence[k][1]);
						break;
						
				}
				
			}
			
		
			
		
			
			(l as DisplayObject).x = storageObject.currentPt.x;
			(l as DisplayObject).y = storageObject.currentPt.y;
			(l as DisplayObject).rotation = storageObject.rotation;
			
			addChild(l as DisplayObject);
					(l as DisplayObject).rotation = Number(storageObject.rotation); 
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