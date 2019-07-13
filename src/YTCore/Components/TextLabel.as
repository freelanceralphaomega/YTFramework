package YTCore.Components 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.Text.WavyText;
	import YTCore.Utils.AnimText.SplitText;
	import com.flashSpider.Graphics.Drawing;
	import com.flashSpider.Text.TextHandler;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class TextLabel extends Sprite implements IRenderable 
	{
	
		
		private var seq:Sequencer = new Sequencer();
		private var canStep:Boolean = false;
		
	    private var   mtxt:String;    
	    private var   mcol:uint;
	    private var   mfont:String;
	    private var   mfontSize:Number;
	    private var   mbgCol:uint;
	    private var   mbgBorderCol:uint;
	    private var   mbgBorderWidth:Number;
	    private var   mbgAlpha:Number;
	    private var   mbgborderAlpha:Number;
	    private var   mbgShape:String;
		private var   mvpadding:Number;
		private var   mhpadding:Number;
		private var   misBitmap:Boolean;
		
		private var bgHolder:Sprite = new Sprite();
		private var txtHolder:Sprite = new Sprite();
		private var mainHolder:Sprite = new Sprite();
		
		
		
		public function TextLabel(
		
		txt:String,
		col:uint,
		font:String,
		fontSize:Number,
		bgCol:uint=0xFFFFFF,
		bgBorderCol:uint=0x000000,
		bgBorderWidth:Number=1,
		bgAlpha:Number=1,
		bgborderAlpha:Number = 1,
		vpadding:Number = 4,
		hpadding:Number = 4,
		bgShape:String = "",
		isBitmap:Boolean = false
		
		) 
		{
			super();
			
			
			mtxt           =  txt;         
			mcol           =  col;
			mfont          =  font;
			mfontSize      =  fontSize;
			mbgCol         =  bgCol;
			mbgBorderCol   =  bgBorderCol;
			mbgBorderWidth =  bgBorderWidth;
			mbgAlpha       =  bgAlpha;
			mbgborderAlpha =  bgborderAlpha;
			mbgShape       =  bgShape;
			mvpadding = vpadding;
			mhpadding = hpadding;
			misBitmap = isBitmap;
			
			setup();
			
		}
		
		
		private function setup():void
		{
			addChild(mainHolder);
			mainHolder.addChild(bgHolder);
			mainHolder.addChild(txtHolder);
			
			//var tf:TextField = TextHandler.setText(txtHolder, mtxt, mfont, 0, 0, mcol, mfontSize);
			
			var st:SplitText = new SplitText(mtxt, mfont, mfontSize, [mcol], misBitmap);
			
			txtHolder.addChild(st);
			
			Drawing.drawRectangle(bgHolder, st.height+2*mvpadding, st.width+2*mhpadding, 0, 0, true, mbgCol, mbgBorderCol, mbgBorderWidth, mbgAlpha,mbgborderAlpha);
			
			st.x = (bgHolder.width - txtHolder.width) / 2;
			st.y = (bgHolder.height-txtHolder.height) / 2;
			
			
		}
		
		/* INTERFACE Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			
			
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