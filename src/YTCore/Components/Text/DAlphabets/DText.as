package YTCore.Components.Text.DAlphabets 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.Text.DLetter;
	import YTCore.Effects.EffectPreset;
	import YTCore.Utils.Helper;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DText extends Sprite implements IRenderable 
	{
		private var seq:Sequencer = new Sequencer();
		private var canStep:Boolean = false;
		private var letterArray:Array;
		private var mlineCol:Number;
		private var mfillCol:Number;
		private var mfillAlpha:Number;
		private var dlArr:Array = [];
		private var ff:Class;
		private var tx:Sprite;
		private var dtm:Number;
		private var wsp:Number;
		
		public function DText(fontFamily:Class, text:String, lineCol:Number, fillCol:Number, fillAlpha:Number, texture:Sprite, drawTime:Number = 4, wordSpace:Number = 1 ) 
		{
			super();
			mlineCol = lineCol;
			mfillCol = fillCol;
			mfillAlpha = fillAlpha;
			letterArray = text.split("");
			ff = fontFamily;
			tx = texture;
			dtm = drawTime;
			wsp = wordSpace;
			
			setup();
			
		}
		
		
		private function setup():void
		{
			var km:Array = [];
			var ll:Array = [];
			var pos:Number = 0;
			for (var d:int = 0; d < letterArray.length; d++)
			{
				if (letterArray[d] != " ")
				{
				var dL:DLetter = new DLetter(ff, letterArray[d], mlineCol, mfillCol, mfillAlpha, tx,dtm);
				addChild(dL);
				ll.push(dL);
				km.push([dL,0]);
				dL.x = pos;
				
				if (letterArray[d] == "V")
				dL.x += 10;
				
				pos += dL.width;
				
				}
				else
				{
					pos += 50*wsp;
				}
				
				if (letterArray[d] == "O")
				pos -= 20;
				if (letterArray[d] == "W")
				pos -= 20;
				if (letterArray[d] == "V")
				pos -= 25;
			}
			
			//Helper.addBackToBackDependency(seq,ll);
			seq.initSequence(km);
			
		}
		
		
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