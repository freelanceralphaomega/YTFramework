package YTCore.CustomScript 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ScriptEvent extends Event 
	{
		public static const EXECUTE:String = "execute";
		public static const DISPATCH:String = "dispatch";
		
		private var dd:*;
		public function ScriptEvent(type:String, dat:*, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			dd = dat;
			
		}
		
		public function get data():*
		{
			return dd;
		}
		
	}

}