package YTCore.Utils.Renderer 
{
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Global;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class RenderController extends Sprite 
	{
		private var imGen:ImageGenerator;
		private var rCon:RenderControl = new RenderControl();
		private var renderMode:Boolean = false;
		private var moviePlaying:Boolean = false;
		
		private var mwid:Number;
		private var mhei:Number;
		private var mrenderOb:DisplayObject;
		private var isShowing:Boolean = true;
		
		public function RenderController(wid:Number,hei:Number,renderOb:DisplayObject) 
		{
			super();
			
			mwid = wid;
			mhei = hei;
			mrenderOb = renderOb;
			
			imGen = new ImageGenerator(mwid, mhei, true);
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStg);
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			
			addChild(rCon);
			
			rCon.render.addEventListener(MouseEvent.MOUSE_DOWN, onR);
			rCon.mov.addEventListener(MouseEvent.MOUSE_DOWN, onMov);
			rCon.showhide.addEventListener(MouseEvent.MOUSE_DOWN, onshowHide);
			
			rCon.render.buttonMode = true;
			rCon.mov.buttonMode = true;
			rCon.showhide.buttonMode = true;
		}
		
		private function onshowHide(e:MouseEvent):void 
		{
				if (isShowing)
			{
			     isShowing = false;
				rCon.showhide.gotoAndStop(2);
				Global.renderCanvas.visible = false;
			}else
			{
				 isShowing = true;
				rCon.showhide.gotoAndStop(1);
				Global.renderCanvas.visible = true;
			}
		}
		
		public function render():void
		{
			imGen.renderToFile(mrenderOb);
		}
		
		private function onR(e:MouseEvent):void 
		{
			if (renderMode)
			{
				renderMode = false;
				rCon.render.gotoAndStop(1);
				this.dispatchEvent(new YTEvent(YTEvent.RENDER_STOP));
			}else
			{
				renderMode = true;
				rCon.render.gotoAndStop(2);
				
			imGen.initRenderToFile(rCon.loc.text, rCon.fname.text);
			
				
				this.dispatchEvent(new YTEvent(YTEvent.RENDER_START));
			}
		}
		
		public function set PERCENTAGE(pp:Number):void
		{
			rCon.pct.text = Math.floor(pp).toString()+"%";
		}
		
		private function onMov(e:MouseEvent):void 
		{
			if (moviePlaying)
			{
				moviePlaying = false;
				rCon.mov.gotoAndStop(1);
				this.dispatchEvent(new YTEvent(YTEvent.MOVIE_STOP));
			}else
			{
				moviePlaying = true;
				rCon.mov.gotoAndStop(2);
				this.dispatchEvent(new YTEvent(YTEvent.MOVIE_START));
			}
		}
		
	}

}