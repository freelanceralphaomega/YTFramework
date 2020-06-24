package YTCore.Animators 
{
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import com.flashSpider.Graphics.Drawing;
	import starling.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class UniformGrowth implements IRenderable 
	{
		
		private var canStep:Boolean = false;
		public var FINISHED:Boolean = false;
		private var mspr:Sprite;
		private var mfrom:Point
		private var mto:Point;
		private var mcol:uint;
		private var minitThickness:Number;
		private var mfinalThickness:Number;
		private var mtime:Number;
		private var malp:Number;
		
		private var currenThickness:Number;
		private var incrementPerFrame:Number;
		
		private var frameCount:int = 0;
		
		
		public function UniformGrowth(spr:Sprite,from:Point,to:Point,col:uint,initThickness:Number,finalThickness:Number,time:Number,alp:Number=1) 
		{
			
			
			mspr               = spr           ;
			mfrom              = from          ;
			mto                = to            ;
			mcol               = col           ;
			minitThickness     = initThickness ;
			mfinalThickness    = finalThickness;
			mtime              = time          ;
			malp               = alp           ;
			
			currenThickness = initThickness;
			
			incrementPerFrame = (finalThickness - initThickness) / (time*Global.FRAME_RATE);
			
		}
		
		public function updateThickness():void
		{
			mspr.graphics.clear();
			
			if (currenThickness >= mfinalThickness)
			{
			stop();
			FINISHED = true;
			}
			
			try{
			//!!Drawing.drawLine(mspr, mfrom.x, mfrom.y, mto.x, mto.y, mcol, malp, currenThickness);
			}catch(e:Error){}
			currenThickness += incrementPerFrame;
			
		}
		
		/* INTERFACE Interface.IRenderable */
		
		public function step():void 
		{
			if (!canStep)
			return;
			
			updateThickness();
			
		}
		
		public function stop():void 
		{
			 canStep = false;
		}
		
		public function start():void 
		{
			canStep = true;
		}
		
	}

}