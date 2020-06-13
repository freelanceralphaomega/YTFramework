package YTCore.Utils 
{
	import YTCore.Utils.Renderer.RenderController;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class Global 
	{
		public static var FRAME_RATE:int = 60;
        
		//public static const SCRIPT_PATH:String = "G:/Sushil/Work&Code/YTFramework/src/YTSCRIPTS/";
		public static var SCRIPT_PATH:String = "F:/Sushil/Work&Code/YTFramework/src/YTSCRIPTS/MISSING_SQUARE/";
		public static var SHAPE_PATH:String =  "F:/Sushil/Work&Code/YTFramework/src/YTShapes/";
		public static var TEXT_PATH:String = "D:/Development/FLASH/YTFramework/RESOURCES/Poems/";
		
		public static var RENDER_PATH:String = "E:/YTRendered/";
		
		public static var CANVAS_COLOR:uint = 0xABCDEF;
		public static var RENDER_STAGE_WIDTH:Number = 500;
		public static var RENDER_STAGE_HEIGHT:Number = 1600;
		public static var RENDER_TIME:Number = 10;
		public static var SCALE_MODE:String = "SHOW_ALL";
		
		public static var renderCanvas:Sprite;
		public static var controller:RenderController;
		
		public static var isAuthoringEnvironment:Boolean = true;
		
		
		public static var renderEnabled:Boolean = false;
		public static var movieEnabled:Boolean = false;
		
		public function Global() 
		{
			
		}
		
	}

}