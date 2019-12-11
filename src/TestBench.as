package 
{
	import YTCore.Abstract.Math.COMMON.MathFunction;
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Abstract.Math.COMMON.UtilMathFunction;
	import YTCore.Animators.ActionScheduler;
	import YTCore.Animators.PathTraverser;
	import YTCore.Animators.PropertyChanger;
	import YTCore.Animators.Sequencer;
	import YTCore.Animators.TimeAnimation;
	import YTCore.Components.CompoundComps.DHair;
	import YTCore.Components.DCircleSegment;
	import YTCore.Components.DLine;
	import YTCore.Components.DSegment;
	import YTCore.Components.DSketch;
	import YTCore.Components.DTriangle;
	import YTCore.Components.GraphPaper;
	import YTCore.Components.Plotter;
	import YTCore.Components.PointConnector;
	import YTCore.Components.PolygonShape;
	import YTCore.Components.Templates.Alphabet.Font2;
	import YTCore.Components.Templates.LineArt;
	import YTCore.Components.Templates.LineDrawing;
	import YTCore.Components.Text.DAlphabets.DText;
	import YTCore.Components.Text.DLetter;
	import YTCore.Components.Text.FontDictionary;
	import YTCore.Components.Text.MultilineRunningText;
	import YTCore.Components.Text.RunningText;
	import YTCore.Components.Text.WavyText;
	import YTCore.Components.TextLabel;
	import YTCore.CustomScript.ScriptClassifier.LineScript;
	import YTCore.CustomScript.ScriptInterpreter;
	import YTCore.CustomScript.ScriptManager;
	import YTCore.Derived.Circular.CIRC_1;
	import YTCore.Derived.Circular.CIRC_2;
	import YTCore.Derived.Curves.SineCurve;
	import YTCore.Derived.INTRO_1;
	import YTCore.Derived.INTRO_2;
	import YTCore.Derived.INTRO_3;
	import YTCore.Derived.INTRO_4;
	import YTCore.Derived.INTRO_GRAPH;
	import YTCore.Derived.MovingLines.MOVING_LINE_1;
	import YTCore.Derived.Patterns.Pattern_P1;
	import YTCore.Derived.Patterns.Pattern_P2;
	import YTCore.Derived.Patterns.Pattern_P3;
	import YTCore.Derived.Rectangular.RECT_1;
	import YTCore.Derived.ScreenFiller.LineFillers;
	import YTCore.Effects.EffectPreset;
	import YTCore.Events.YTEvent;
	import YTCore.Graphics.TextureLibrary;
	import YTCore.Utils.AnimText.SplitText;
	import YTCore.Utils.ExpressionHandler.ExpressionEvaluator;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Global;
	import YTCore.Utils.Helper;
	import YTCore.Utils.Misc.TestObject;
	import YTCore.Utils.Misc.Tester;
	import YTCore.Utils.SegmentManager;
	import YTCore.Utils.StyleEditor;
	import YTCore.Utils.Tweener.WaveSp;
	import com.flashSpider.Graphics.Drawing;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.engine.FontLookup;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TestBench extends Sprite 
	{
		
		private var seq:Sequencer = new Sequencer();
		private var isAnimating:Boolean = false;
		
		private var frameCount:int = 0;
		
		
		
		//private var ptCon = new PointConnector(MathHandler.getCosPtArr(100/180,50,0,1600,3),0xFFFF00,15,170);
		//private var ptCon:PointConnector = new PointConnector(MathHandler.getCirclePts(200,-100,100,10,2),0xFFFFFF,10,3);
		//private var ptCon = new PointConnector([new Point(0, 0), new Point(200, 0),new Point(200, 200),new Point(400,200),new Point(0,0)],0xFFFFFF,2,10);
		
		//private var ptCon:DCircleSegment = new DCircleSegment(160, 100, 0xFFFFFF, 5,45);
		//private var ptCon:DSegment = new DSegment(360, 100, 0xFFFFFF,5,-1);
		
		//private var ptCon = new PointConnector(MathHandler.getEllipsePtArr(300 / 5, 300 / 5, -5, 5, 2, 3, 50, 2), 0xCC0000, 10, 10);
		//private var ptCon2:PointConnector = new PointConnector(MathHandler.getEllipsePtArr(300/5,300/5,-5,5,2,3,50,2),0xCC0000,10,10);
		
		//private var ptCon:GraphPaper = new GraphPaper();
		//private var ptCon:Plotter = new Plotter(MathHandler.getSinPtArr(-360,360,2),-360,360,-1,1,500/720,400/2);
		
		//private var ptCon:LineDrawing = new LineDrawing(LineArt.MAP_OF_INDIA, .5, 0xFFFF00, 3);
		//private var ptCon:PointConnector=new PointConnector(Helper.pointsFromArr(LineArt.SUSHIL_SIGNATURE), 0xCCCCCC, 5, 50, 50,[[.5,0]]);
		
		//private var ptCon = new PointConnector([new Point(50, 400), new Point(600, 400)], 0xCCCC00, 5, 50, 50,[[.2,100],[.4,30],[.6,0],[.8,0]]);
		//private var ptCon = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0,800,5),400/720,160/1),0x000000,5,300,3,[[.3,10],[.6,40],[.8,150]],true,3,0,.05,2,true);
		//private var ptCon:PointConnector = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0,160,3),600/720,500/1),0xCCCC00,3,100,0,[]);
		//private var ptCon:DLine = new DLine(new Point(0, 0), new Point(400, 0), 0xCC0000, 2, 10, 10, true,1,0,1);
		
		//private var ptCon = new PointConnector(MathHandler.unitToPixelCoordinate(MathHandler.getSinPtArr(0,360*3,10),600/720,200/1),0x660000,2,5,5,null,false,1,.1,1,5)
		
		//private var ptCon:DHair = new DHair();
		
		//private var tob:TestObject = new TestObject();
		
		//private var ptCon:PropertyChanger;
		
		//private var ptCon:RunningText = new RunningText("INTRODUCTION & OVERVIEW", FontDictionary.COLOMA, 400, [0xffffff,0XABCDEF], 1.5, false);
		
		//private var ptCon:DText = new DText(Font2, "SUSHIL     MANDI", 0Xffffff, 0Xdddddd, .9, null);
		
		//private var ptCon:WavyText = new WavyText("Sushil Mandi", "Arial", 30, [0x550000], 10);
		
		private var ptCon:ScriptInterpreter;
		
		//private var ptCon = new DLine(new Point(200, 200), new Point(1000, 200), 0x440000, 5, 10, 50, true, 1,1,1,false,1);
		//private var actSch:ActionScheduler = new ActionScheduler(ptCon, "wipeFromHead", 5); 
		
		//private var ptCon:PointConnector = new PointConnector(,0xCC0000,3,3,3,null,false,1,1,1,3);
		//private var ptCon = new PointConnector([new Point(0,0),new Point(400,0),new Point(400,-400),new Point(800,-400)], 0xCC0000, 3, 7, 7, null, false, 1, .2, 1, 4);
		//private var actSch:ActionScheduler = new ActionScheduler(ptCon, "wipe", 5); 
		
		//private var ptCon = new MultilineRunningText("tangled");
		
		//private var ptCon:DSketch = new DSketch([[[0,0],[800,0],[800,800],[0,0]]],0xCCCCCC,1,[0xAAAA00],[1],[],!true,.1);
		
       // private var ptCon:GraphPaper = new GraphPaper();
		
		//private var ptCon:INTRO_GRAPH = new INTRO_GRAPH(); 
		

		
		public function TestBench() 
		{
			super();
			
			
			if (Tester.enabled)
			{
				Tester.test();
				return;
			}
			
			ptCon = new ScriptInterpreter();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStg); 
			
			
		}
		
		
		private function refresh():void
		{
			frameCount = 0;
		
			ptCon.parent.removeChild(ptCon);
			ptCon   = new ScriptInterpreter();
			
			
			addChild(ptCon);
			seq = new Sequencer();
			seq.initSequence([[ptCon,0]]);
		}
		
		
		private function onStg(e:Event=null):void 
		{
			
			
			removeEventListener(Event.ADDED_TO_STAGE, onStg); 
			
			addChild(ptCon);
			
			
			
			ptCon.scaleX = ptCon.scaleY = 1; 
			ptCon.y = 300;
			

			/*
			EffectPreset.SOFT_BEVEL(ptCon);
			
			EffectPreset.SOFT_SHADOW(ptCon);
			
			StyleEditor.applyShadow(ptCon);
			
		      */
			

		
			
			
			//seq.initSequence([[ptCon,0],[actSch,0]]);
			seq.initSequence([[ptCon,0]]);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKd);
			
			this.addEventListener(Event.ENTER_FRAME, step);
			
		}
		
		private function onKd(e:KeyboardEvent):void 
		{
			if (e.keyCode ==  Keyboard.R)
			{
			if(!Global.isAuthoringEnvironment)
			refresh();
			}
		}
		
		private function toggleAnimation():void
		{
			if (isAnimating)
			{
				isAnimating = false;
				this.removeEventListener(Event.ENTER_FRAME, step);
			}else
			{
				isAnimating = true;
				this.addEventListener(Event.ENTER_FRAME, step);
			}
		}
		
		public function step(e:Event=null):void 
		{
			if(Global.movieEnabled)
			seq.step();
			
			var pct:Number=100 * frameCount / (Global.FRAME_RATE*Global.RENDER_TIME);
			
			if (Global.renderEnabled && Global.movieEnabled && pct<=100)
			{
			Global.controller.render();
			frameCount++;
			}
			
			Global.controller.PERCENTAGE = pct;
			
			
		}
		
	}

}