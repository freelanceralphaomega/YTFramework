package YTCore.Utils.FileManager 
{
	import YTCore.Utils.Global;
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ConfigManager 
	{
		
		public function ConfigManager() 
		{
			
		}
		
		public static function setConf():void
		{
			var str:String = FileLoader.readMain();
			
			
			
			
			var exp:RegExp = /config\s*\[\s*[\w\=\d;&:_\/\.\s]*\]/i;
			
			var confBl:String = exp.exec(str);
		
			
			
			
			var canvWid:Number = Number(/\d+/.exec(/canvasWidth\s*=\s*\d*\s*;/i.exec(confBl)));
			var canvHei:Number = Number(/\d+/.exec(/canvasHeight\s*=\s*\d*\s*;/i.exec(confBl)));
			var renderTime:Number = Number(/\d+/.exec(/renderTime\s*=\s*\d*\s*;/i.exec(confBl)));
			var canvColor:Number = Number(/0x[A-F0-9]{6}/.exec(/canvasColor\s*=\s*0x[A-F0-9]{6}\s*;/i.exec(confBl)));
			var frameRate:Number = Number(/\d+/.exec(/frameRate\s*=\s*\d*\s*;/i.exec(confBl)));
			
			var scriptPath:String = /\w:[\/\w\d\&\.:_]*/.exec(/scriptPath\s*=\s*\w:[\/\w\d\&\.:_]*s*;/i.exec(confBl));
			
			var renderPath:String = /\w:[\/\w\d\&\.:_]*/.exec(/renderPath\s*=\s*\w:[\/\w\d\&\.:_]*s*;/i.exec(confBl));
			
			var shapePath:String = /\w:[\/\w\d\&\.:_]*/.exec(/shapePath\s*=\s*\w:[\/\w\d\&\.:_]*s*;/i.exec(confBl));
			
			trace("CONFIGMANAGER RenderPath: ",renderPath);
			
			var scaleMode:String =  /\w+_\w+/i.exec(confBl);
			
		   Global.RENDER_STAGE_WIDTH = canvWid;
		   Global.RENDER_STAGE_HEIGHT = canvHei;
		   Global.RENDER_TIME = renderTime;
		   Global.FRAME_RATE = frameRate;
		   Global.CANVAS_COLOR = canvColor;
		   Global.SCALE_MODE = scaleMode;
		   Global.SCRIPT_PATH = scriptPath;
		   Global.RENDER_PATH = renderPath;
		   Global.SHAPE_PATH = shapePath;
			
			
			
		}
	}

}