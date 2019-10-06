package
{
	//import Components.DLine;
	import YTCore.Components.DLine;
	import YTCore.Components.DTriangle;
	import YTCore.Components.PolygonShape;
	import YTCore.Components.Templates.LineArt;
	import YTCore.Components.Templates.LineDrawing;
	import YTCore.Events.YTEvent;
	import YTCore.Graphics.TextureLibrary;
	import YTCore.Utils.FileManager.ConfigManager;
	import YTCore.Utils.Global;
	import YTCore.Utils.RenderCanvas;
	import YTCore.Utils.Renderer.RenderController;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	
	 [SWF(frameRate="60", backgroundColor="0xffffff")]
	public class Main extends Sprite 
	{
		private var t:TestBench;
		private var rController:RenderController;
		private var rendCanv:RenderCanvas;
	
		
		
		public function Main() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStg);
			
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			
			
			ConfigManager.setConf();
			
			t= new TestBench();
			
			stage.scaleMode = StageScaleMode[Global.SCALE_MODE];
            stage.align     = StageAlign.TOP_LEFT; 
			
			
			
			
			var h:Number = Global.RENDER_STAGE_HEIGHT+200;
			
			
			var w:Number = Global.RENDER_STAGE_WIDTH;
			if (w < 500)
			w = 500;
			
			stage.nativeWindow.width = w;
			stage.nativeWindow.height =h;
			
		
			
			//stp.addEventListener(MouseEvent.MOUSE_DOWN, onD);
			
			rendCanv = new RenderCanvas(Global.RENDER_STAGE_WIDTH, Global.RENDER_STAGE_HEIGHT, Global.CANVAS_COLOR);
			addChild(rendCanv);
			//addChild(pg);
			//rendCanv.scaleX = rendCanv.scaleY = .7;
			//rendCanv.x = 10;
			//rendCanv.y = 10;
			
			Global.renderCanvas = rendCanv.RENDER_CANVAS;
			
			rController = new RenderController(Global.RENDER_STAGE_WIDTH, Global.RENDER_STAGE_HEIGHT, Global.renderCanvas);
			
			Global.controller = rController;
			
			
			
			//rController.x = rendCanv.x + rendCanv.width + 5;
			//rController.y = (stage.stageHeight - rController.height) / 2;
			
			rController.addEventListener(YTEvent.MOVIE_START, movStart);
			rController.addEventListener(YTEvent.MOVIE_STOP, movStop);
			rController.addEventListener(YTEvent.RENDER_START, renderStart);
			rController.addEventListener(YTEvent.RENDER_STOP, renderStop);
			
			rendCanv.RENDER_CANVAS.addChild(t);
			
			addChild(rController);
			
			rController.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			rController.addEventListener(MouseEvent.MOUSE_UP, onDragStop);
			
			
			
		}
		
		private function onDragStop(e:MouseEvent):void 
		{
			rController.stopDrag();
		}
		
		private function onDrag(e:MouseEvent):void 
		{
			rController.startDrag();
		}
		
		private function renderStop(e:YTEvent):void 
		{
			Global.renderEnabled = false;
			trace("Render stopped");
		}
		
		private function renderStart(e:YTEvent):void 
		{
			Global.renderEnabled = true;
			trace("Render Started");
			t.step();
		}
		
		private function movStop(e:YTEvent):void 
		{
			Global.movieEnabled = false;
			trace("Movie stopped");
		}
		
		private function movStart(e:YTEvent):void 
		{
			Global.movieEnabled = true;
			
			//t.stepMax();
			
			trace("Movie Started");
		}
		
		private function onD(e:MouseEvent):void 
		{
			t.step();
		}
		
	}
	
}