/*

Author: Sushil Mandi
Copyright: www.mandilab.com

*/


package starling
{

	

	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	
	public class MainStarling extends Sprite
	{
	
		public static var myStarling:Starling;
		
		
		private var screenWidth:int;
		private var screenHeight:int
		

		
		
		public function MainStarling()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStg);
			
		
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			init();
		}
		
		
		private function init():void
		{
			
			
		
			screenWidth = 1920;//stage.fullScreenWidth;
			screenHeight = 1080;// stage.fullScreenHeight;
			
			
			var viewPort:Rectangle=new Rectangle(0,0,screenWidth,screenHeight);
			
			
			//Set device properties
			
			Starling.handleLostContext=true;
			
			MainStarling.myStarling=new Starling(StarlingBase,stage,viewPort);
			
		//	myStarling=new Starling( Game, this.stage, viewPort, null, Context3DRenderMode.AUTO,
			//	[ Context3DProfile.BASELINE_CONSTRAINED ] );
			
			MainStarling.myStarling.stage.stageWidth=768*(screenWidth/screenHeight);
			MainStarling.myStarling.stage.stageHeight=768;
			
	
	
			MainStarling.myStarling.antiAliasing=4;
			
			MainStarling.myStarling.showStats = !false;
			
			//myStarling.showStatsAt("left", "top");
			MainStarling.myStarling.start();
			
		}
	
	
		
	}
}