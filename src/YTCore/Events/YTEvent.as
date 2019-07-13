package YTCore.Events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class YTEvent extends Event 
	{
		public static const FINISHED:String = "finished";
		public static const RENDER_START:String = "renderStart";
		public static const RENDER_STOP:String = "renderStop";
		public static const MOVIE_START:String = "movieStart";
		public static const MOVIE_STOP:String = "movieStop";
		public function YTEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}