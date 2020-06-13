package YTCore.Utils.FileManager 
{
	import YTCore.Utils.Global;
	import com.flashSpider.Utils.TextFileLoader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author ...
	 */
	public class FileLoader 
	{
		
		public function FileLoader() 
		{
			
		}
		
		public static function readMain():String
		{
			var f:File = File.desktopDirectory;
			f = f.resolvePath("YTF/Main.txt");
			
			
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			
			var s:String = fs.readUTFBytes(fs.bytesAvailable);
			
			fs.close();
			return s;
		}
		
		public static function readScript(scriptName:String):String
		{
			
			
			var f:File = new File();
			f.nativePath =  Global.SCRIPT_PATH + scriptName;
			
			trace("FileLoader: ",f.nativePath);
			
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			
			var s:String = fs.readUTFBytes(fs.bytesAvailable);
			
			fs.close();
			return s;
			
		}
		
		public static function readShape(shapeName:String):String
		{
			var f:File = new File();
			f.nativePath = Global.SHAPE_PATH + shapeName+".txt";
			
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			
			var s:String = fs.readUTFBytes(fs.bytesAvailable);
			
			fs.close();
			return s.split(" ").join("").split("\r\n").join("");
		}
		
		
       public static function readMLText(fname:String):String
		{
			var f:File = new File();
			f.nativePath = Global.TEXT_PATH + fname+".txt";
			
			trace(f.nativePath);
			
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			
			var s:String = fs.readUTFBytes(fs.bytesAvailable);
			
			fs.close();
			return s;
		}
		
		
	}

}