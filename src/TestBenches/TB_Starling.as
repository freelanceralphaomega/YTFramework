package TestBenches
{

	import YTCore.Utils.Global;
	import YTCore.Utils.Misc.Tester;
	import com.hurlant.eval.ast.NewExpr;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import YTCore.Animators.Sequencer;
	import flash.display.Stage;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.StarlingBase;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TB_Starling extends Sprite 
	{
		
		private var myStarling:Starling;
		private var screenWidth:int;
		private var screenHeight:int
		
		private var seq:Sequencer = new Sequencer();
		private var isAnimating:Boolean = false;
		private var frameCount:int = 0;
		private var ptCon;
		
		
		

		
		public function TB_Starling()
		{
			super();
			
			
			
		//	ptCon= new HandWriting("#0x440000 [This is `sig` `nl:-100,300` What]??? #0x000000 `inf`#0x111100 eeds done" + 
		
		//" #0x001100 `nl:-100,300` #0x000011 What is  wrong with you `nl:0,400` `int``int``sig`This is real shit",feather); 
			
		
			if (Tester.enabled)
			{
				Tester.test(); 
				return;
			}
			
			
			
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, onStg); 
			
			
		}
		
		public function get context():Context3D
		{
			return myStarling.context;
		}
		
		
		private function refresh():void
		{
			frameCount = 0;
		
			ptCon.parent.removeChild(ptCon);
			
			
			addChild(ptCon);
			seq = new Sequencer();
			seq.initSequence([[ptCon,0]]);
		}
		
		
		private function init():void
		{
		
			screenWidth = 1920;//stage.fullScreenWidth;
			screenHeight = 1080;// stage.fullScreenHeight;
			
			
			var viewPort:Rectangle=new Rectangle(0,0,screenWidth,screenHeight);
			
			
			//Set device properties
			
			Starling.handleLostContext=true;
			
			myStarling=new Starling(StarlingBase,stage,viewPort);
			
		//	myStarling=new Starling( Game, this.stage, viewPort, null, Context3DRenderMode.AUTO,
			//	[ Context3DProfile.BASELINE_CONSTRAINED ] );
			
			myStarling.stage.stageWidth=768*(screenWidth/screenHeight);
			myStarling.stage.stageHeight=768;
			
	
	
			myStarling.antiAliasing=4;
			
			myStarling.showStats = false;
			
			//myStarling.showStatsAt("left", "top");
			myStarling.start();
			
			
			
		}
		
		
		
		private function onStg(e:flash.events.Event=null):void 
		{
			
			init();
			
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, onStg); 
			
			StarlingBase.dispatcher.addEventListener("ready", orReady);
			
		}
		
		private function orReady(e:flash.events.Event=null):void 
		{
			
			StarlingBase.dispatcher.removeEventListener("ready", orReady);
			
				ptCon = StarlingBase.t;
				seq.initSequence([[ptCon, 0]]);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKd);
			
			//this.addEventListener(Event.ENTER_FRAME, step);
			
			//Starling.dispatcher.addEventListener("beforePresent", step);
			
			myStarling.stage.addEventListener(Event.READY_TO_RENDER,step);
	
			//myStarling.addEventListener(Event.RENDER, step);
			//StarlingBase.dispatcher.addEventListener("enterFrame",step);
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
				//!this.removeEventListener(Event.ENTER_FRAME, step);
				myStarling.removeEventListener(Event.RENDER,step);
			}else
			{
				isAnimating = true;
				//!this.addEventListener(Event.ENTER_FRAME, step);
				myStarling.removeEventListener(Event.RENDER,step);
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
			trace("Before present","trying to render....");
			}
			
			Global.controller.PERCENTAGE = pct;
			
			
		}
		
	}

}