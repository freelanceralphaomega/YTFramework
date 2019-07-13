package YTCore.CustomScript.ScriptClassifier 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DLine;
	import YTCore.Components.GraphPaper;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	
	 

	 
	public class GraphScript extends Sprite implements IRenderable 
	{
		
	 private var seq:Sequencer = new Sequencer();
	 private var commandString:String;
	 
	 
	 private var isLocal:Boolean = true;
	 
	 
	 private var dlineArr:Array = [];
	 
	 private var canStep:Boolean = false;
		
	 
	 private var lObj:Object;
	 private var gObj:Object;
	 
		public function GraphScript(command:String,globalOb:Object=null) 
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
			storageObject.ppx                 =  600/10 ;
			storageObject.ppy                 =  600/10 ;
			storageObject.mainDivX            =   1;
			storageObject.mainDivY            =   1;
			storageObject.subDivCountX        =   1;
			storageObject.subDivCountY        =   1;
			storageObject.origX               =   0;
			storageObject.origY               =   0;
			storageObject.xAxisCol            =   0xCCCCCC;
			storageObject.yAxisCol            =   0xCCCCCC;
			storageObject.xAxisWid            =   1;
			storageObject.yAxisWid            =   1;
			storageObject.subDivCol           =   0xAAAAAA;
			storageObject.mainDivCol          =   0xAAAAAA;
			storageObject.drawTime            =   4;
			storageObject.subDivWid           =   1;
			storageObject.mainDivWid          =   1;
			storageObject.axisWid             =   1;
			storageObject.boundingBoxCol      =   0x999999;
			storageObject.boundingBoxWid      =   1;
			storageObject.markingWid          =   1;
			storageObject.labelCol            =   0xABCDEF;
			storageObject.labelFont           =   "Arial";
			storageObject.labelFontSize       =   20;
	       
	      
			
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
				var l:GraphPaper;
				
				var ts:String = (commandSequence[k][0] as String).toUpperCase();
				
				
				
				switch(ts)
				{

					case "MOVE":
						
					p = (commandSequence[k][1] as String).split(",");
					storageObject.currentPt = new Point(p[0],p[1]);
						
						break;
						
						
					case "WIDTH":
					storageObject.width= Number(commandSequence[k][1]);
						break;
					case "HEIGHT":
					storageObject.height= Number(commandSequence[k][1]);
						break;
					case "PPX":
					storageObject.ppx= Number(commandSequence[k][1]);
						break;
					case "PPY":
					storageObject.ppy= Number(commandSequence[k][1]);
						break;
						case "MAINDIVX":
					storageObject.mainDivX= Number(commandSequence[k][1]);
						break;
						case "MAINDIVY":
					storageObject.mainDivY= Number(commandSequence[k][1]);
						break;
						case "SUBDIVCOUNTX":
					storageObject.subDivCountX= Number(commandSequence[k][1]);
						break;
						case "SUBDIVCOUNTY":
					storageObject.subDivCountY= Number(commandSequence[k][1]);
						break;
						case "ORIGX":
					storageObject.origX= Number(commandSequence[k][1]);
						break;
						case "ORIGY":
					storageObject.origY= Number(commandSequence[k][1]);
						break;
						case "XAXISCOL":
					storageObject.xAxisCol= Number(commandSequence[k][1]);
						break;
						case "YAXISCOL":
					storageObject.yAxisCol= Number(commandSequence[k][1]);
						break;
						case "XAXISWID":
					storageObject.xAxisWid= Number(commandSequence[k][1]);
						break;
					case "YAXISWID":
					storageObject.yAxisWid= Number(commandSequence[k][1]);
						break;
					case "SUBDIVCOL":
					storageObject.subDivCol= uint(commandSequence[k][1]);
						break;
					case "MAINDIVCOL":
					storageObject.mainDivCol= uint(commandSequence[k][1]);
						break;
					case "DRAWTIME":
					storageObject.drawTime= Number(commandSequence[k][1]);
						break;
					case "SUBDIVWID":
					storageObject.subDivWid= Number(commandSequence[k][1]);
						break;
					case "MAINDIVWID":
					storageObject.mainDivWid= Number(commandSequence[k][1]);
						break;
					case "AXISWID":
					storageObject.axisWid= Number(commandSequence[k][1]);
						break;
					case "BOUNDINGBOXCOL":
					storageObject.boundingBoxCol= uint(commandSequence[k][1]);
						break;
					case "BOUNDINGBOXWID":
					storageObject.boundingBoxWid= Number(commandSequence[k][1]);
						break;
					case "MARKINGWID":
					storageObject.markingWid= Number(commandSequence[k][1]);
						break;
					case "LABELCOL":
					storageObject.labelCol= uint(commandSequence[k][1]);
						break;
					case "LABELFONT":
					storageObject.labelFont= commandSequence[k][1];
						break;
					case "LABELFONTSIZE":
					storageObject.labelFontSize= Number(commandSequence[k][1]);
						break;
			
				}
				
			}
			
			
					
			l = new GraphPaper
			(
			storageObject.width,
			storageObject.height,
			storageObject.ppx,
			storageObject.ppy,
			storageObject.mainDivX,
			storageObject.mainDivY,
			storageObject.subDivCountX,
			storageObject.subDivCountY,
			storageObject.origX,
			storageObject.origY,
			storageObject.xAxisCol,
			storageObject.yAxisCol,
			storageObject.xAxisWid,
			storageObject.yAxisWid,
			storageObject.subDivCol,
			storageObject.mainDivCol,
			storageObject.drawTime,
			storageObject.subDivWid,
			storageObject.mainDivWid,
			storageObject.axisWid,
			storageObject.boundingBoxCol,
			storageObject.boundingBoxWid,
			storageObject.markingWid,
			storageObject.labelCol,
			storageObject.labelFont,
			storageObject.labelFontSize
			
			);
			
			l.showLabel = false;
			
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