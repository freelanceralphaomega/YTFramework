package TestBenches
{

	import YTCore.Components.Text.MultilineRunningText;
	import YTCore.Components.Text.NaturalHW.HandWriting;
	import YTCore.Derived.Circular.CIRC_1;
	import YTCore.Derived.Circular.CIRC_2;
	import YTCore.Derived.Patterns.Pattern_P1;
	import YTCore.Derived.Patterns.Pattern_P2;
	import YTCore.Derived.Patterns.Pattern_P3;
	import YTCore.Derived.Patterns.Pattern_P4;
	import YTCore.Derived.Patterns.Pattern_P5;
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
	public class TestBench_3 extends Sprite 
	{
		
		private var seq:Sequencer = new Sequencer();
		private var isAnimating:Boolean = false;
		
		private var frameCount:int = 0;
		
		
		private var hand:Hand2 = new Hand2();
		private var feather = new Feather4();
		
		
		
		private var ptCon:HandWriting; 
		
		

		
		public function TestBench_3()
		{
			super();
			
			addChild(feather);
			feather.scaleX = feather.scaleY = .4;
			
			ptCon= new HandWriting("#0x440000 [This is `sig` `nl:-100,300` What]??? #0x000000 `inf`#0x111100 eeds done" + 
		
		" #0x001100 `nl:-100,300` #0x000011 What is  wrong with you `nl:0,400` `int``int``sig`This is real shit",feather); 
			
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
			
			
			
			
			ptCon.scaleX = ptCon.scaleY = .12; 
			
			ptCon.x = 20;
			ptCon.y = 100;
			
			

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