package TestBenches
{

	import YTCore.Components.Text.MultilineRunningText;
	import YTCore.Utils.Global;
	import YTCore.Utils.Misc.Tester;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.engine.FontLookup;
	import flash.ui.Keyboard;
	import YTCore.Animators.Sequencer;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TestBench_1 extends Sprite 
	{
		
		private var seq:Sequencer = new Sequencer();
		private var isAnimating:Boolean = false;
		
		private var frameCount:int = 0;
		
		
		
		private var ptCon = new MultilineRunningText("Title");
		
		

		
		public function TestBench_1()
		{
			super();
			
			
			if (Tester.enabled)
			{
				Tester.test();
				return;
			}
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStg); 
			
			
		}
		
		
		private function refresh():void
		{
			frameCount = 0;
		
			ptCon.parent.removeChild(ptCon);
			
			
			addChild(ptCon);
			seq = new Sequencer();
			seq.initSequence([[ptCon,0]]);
		}
		
		
		private function onStg(e:Event=null):void 
		{
			
			
			removeEventListener(Event.ADDED_TO_STAGE, onStg); 
			
			addChild(ptCon);
			
			
			
			ptCon.scaleX = ptCon.scaleY = 1; 
			ptCon.y = 50;
			

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