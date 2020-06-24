package starling
{
	
	import YTCore.Components.DLine;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.display.Quad;
	import flash.events.EventDispatcher;
	import starling.events.EnterFrameEvent;
	
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingBase extends Sprite
	{
		public static var t:DLine;
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		public function StarlingBase()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onstg);
			
			
		}
		
		
		private function onstg(event:Event):void
		{
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onstg);
			
			var dl:DLine = new DLine(new Point(0, 0), new Point(600, 300),0xFF0000,5,100,2);
			addChild(dl);
			
			StarlingBase.t = dl;
			
			StarlingBase.dispatcher.dispatchEvent(new flash.events.Event("ready"));
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onFr);
		}
		
		private function onFr(e:Event):void 
		{
			StarlingBase.dispatcher.dispatchEvent(new flash.events.Event("enterFrame"));
		}
		
		
	}
}