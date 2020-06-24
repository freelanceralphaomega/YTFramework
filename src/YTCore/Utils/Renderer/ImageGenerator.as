package YTCore.Utils.Renderer
{
	import YTCore.Utils.Global;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import starling.MainStarling;
	
	/*
		Stage 3D to PNG by Dawson Valdes
		This is a utility class for rendering out the content of the Stag3d context3D to a PNG file
	*/
	
	public class ImageGenerator
	{
		import flash.utils.ByteArray;
		import flash.display3D.Context3D;
		import flash.display.BitmapData;
		import flash.display.PNGEncoderOptions;
		import flash.geom.Rectangle;
		import flash.filesystem.FileStream;
		import flash.filesystem.FileMode;
		import flash.filesystem.File;
		

		private var _PNGoptions:PNGEncoderOptions;
		private var _fileIterator:int;
		private var _fileName:String;
		private var _outPutDirectory:File;
	
		
		private var nPath:String = Global.RENDER_PATH;
		
		
		
		private var _bitmapRect:Rectangle;
		private var _useRGBA:Boolean;
		private var _inited:Boolean;
		
		private var rootPath:String = "";
		
		public function ImageGenerator( width:int , height:int , useRGBA:Boolean)
		{
			_bitmapRect = new Rectangle( 0 , 0 , width , height );
			_useRGBA = useRGBA;
			_inited = false;

		}
		
		public function initRenderToFile( outputFolder:String = "output" , fileName:String = "output" , compression:Boolean = false ):void
		{
			//Setting up PNG options: true for fast encoding, false for more compression
			_PNGoptions = new PNGEncoderOptions(!compression);
			
			// setting up output file location and naming
			_fileIterator = new int(0);
			_fileName = fileName;
			
			var file:File = new File();
			file.nativePath = nPath+outputFolder;
			
			//_outPutDirectory = File.documentsDirectory.resolvePath(outputFolder);
			_outPutDirectory = file;
			_outPutDirectory.createDirectory();
			_inited = true;
		}
		
		//this should be called after a frame has been drawn and Context3D.present() has been called
		public function renderToFile(dispObj:DisplayObject, context:Context3D=null ):void
		{
			if (_inited)
			{	
				var renderData:BitmapData = new BitmapData( _bitmapRect.width , _bitmapRect.height , _useRGBA, 0x00000000 );;
				var encodeBytes:ByteArray = new ByteArray();

				var PNGFileStream:FileStream = new FileStream();
				
				var xSub:String="0000";
				if(_fileIterator>=10)
				{
					xSub="000";
					if(_fileIterator>=100)
					{
						xSub="00";
						if(_fileIterator>=1000)
						{
							xSub="0";
							if(_fileIterator>=10000)
							{
								xSub="";
								
							}
						}
					}
				}
				var PNGFile:File = _outPutDirectory.resolvePath( _fileName + "_"+xSub + _fileIterator + ".png" );
			
				// render buffer to bitmapdata
				
			/*	var rsp:RenderSupport = new RenderSupport();
				RenderSupport.clear(stage.color, 1.0);
				rsp.setOrthographicProjection(0,0,_width,_height);
				stage.render(rsp, 1.0);
				support.finishQuadBatch();
			*/	
				if(context!=null)
				context.drawToBitmapData( renderData );
				else
				{
					renderData.draw(dispObj);
				}
						
				//encode bimap with png to bytearray
				renderData.encode( _bitmapRect, _PNGoptions, encodeBytes );
			
				// save to file
				PNGFileStream.open( PNGFile , FileMode.WRITE );
				PNGFileStream.writeBytes( encodeBytes );
				PNGFileStream.close();
			
				// iterate file number
				_fileIterator++;
			}
			else
			{
				trace( "You must initialize the file render with Stage3DPNG.initRenderToFile( Folder , FileName , Compression )" );
			}
				
		}
		
	}
}
