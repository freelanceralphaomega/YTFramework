package YTCore.Components.Text 
{
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.AnimText.SplitText;
	import YTCore.Utils.Global;
	import YTCore.Utils.Tweener.WaveSp;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class WavyText extends Sprite implements IRenderable
	{
		private var _txt:String;
		private var _fnt:String;
		private var _tsize:int;
		private var _colArr:Array;
		private var _isBitmap:Boolean;
		private var _time:Number;
		private var _wScale:Number;
		
		private var frameCount:int = 0;
		
		private var canStep:Boolean = false;
		
		private var waveT:WaveSp = new WaveSp();
		
		private var spt:SplitText;
		public function WavyText(txt:String,fnt:String,tsize:int,colArr:Array,waveTime:Number,waveScale:Number=1,useBitmap:Boolean=true) 
		{
			super();
			
			_txt = txt;
			_fnt = fnt;
			_tsize = tsize;
			_colArr = colArr;
			_isBitmap = useBitmap;
			_time = waveTime;
			_wScale = waveScale;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStg);
			
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			spt = new SplitText(_txt, _fnt, _tsize, _colArr, _isBitmap);
		waveT.waveText(spt.alphabets, 10, 10, _time, _wScale, Global.FRAME_RATE);
			addChild(spt);
		}
		
		public function step():void
		{
			if (!canStep)
			return;
			
			waveT.step();
			frameCount++;
			
			if (frameCount >= Global.FRAME_RATE * _time)
			{
				canStep = false;
				this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			}
			
		}
		
		public function start():void
		{
			canStep = true;
		}
		
		public function stop():void
		{
			canStep = false;
		}
		
	}

}