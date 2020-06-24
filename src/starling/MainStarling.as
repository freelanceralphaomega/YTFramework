/*

Author: Sushil Mandi
Copyright: www.mandilab.com

*/


package starling
{

	

	
	import YTCore.Utils.Global;
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
	
		private var myStarling:Starling;
		
		
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
			
			
			var viewPort:Rectangle=new Rectangle(0,0,Global.RENDER_STAGE_WIDTH,Global.RENDER_STAGE_HEIGHT);
			
			
			//Set device properties
			
			Starling.handleLostContext=true;
			
			myStarling = new Starling(StarlingBase, stage, viewPort);
		
			
			
		//	myStarling=new Starling( Game, this.stage, viewPort, null, Context3DRenderMode.AUTO,
			//	[ Context3DProfile.BASELINE_CONSTRAINED ] );
			
			stage.width = viewPort.width;
			stage.height = viewPort.height;
			
	
	
			antiAliasing=4;
			
			showStats = !false;
			
			//myStarling.showStatsAt("left", "top");
			start();
			
		}
	
	
		
	}
}