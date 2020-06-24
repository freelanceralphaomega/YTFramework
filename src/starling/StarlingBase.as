package starling
{
	
	import YTCore.Components.DLine;
	import YTCore.Components.PointConnector;
	import YTCore.Components.PolygonShape;
	import YTCore.Components.Templates.LineDrawing;
	import YTCore.Components.Text.NaturalHW.HandWriting;
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
		public static var t;
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		public function StarlingBase()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onstg);
			
			
		}
		
		
		private function onstg(event:Event):void
		{
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onstg);
			
			var dl = new HandWriting("This text is rendered in Starling!", null);
			dl.x = 200;
			dl.y = 300;
			dl.scaleX = dl.scaleY = .3;
			addChild(dl);
			
			StarlingBase.t = dl;
			
			StarlingBase.dispatcher.dispatchEvent(new flash.events.Event("ready"));
			
		}
		
		
		
	}
}