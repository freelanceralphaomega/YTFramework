package YTCore.Components.Text.NaturalHW 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DSketch;
	import YTCore.Components.PointConnector;
	import YTCore.Components.Text.NaturalHW.HWInfo.Hinfo_Sushil;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Helper;
	import com.flashSpider.Graphics.Drawing;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author SushilM
	 */
	public class HandWriting extends Sprite implements IRenderable 
	{
		
		private var seq:Sequencer = new Sequencer();
		private var canStep:Boolean = false;
		private var str:String;
		
		public function HandWriting(txt:String) 
		{
			super();
			str = txt;
			
			setup();
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		private function setup():void 
		{
			var lastDrawPos:Number = 0;
			var fontAr:Array = [];
			var lArr:Array = str.split("");
			for (var d:int = 0; d < lArr.length; d++) 
			{
				if (lArr[d] == " ")
				{
				lastDrawPos += 90;
				continue;
				}
				var shapeArr:Array = Helper.getArrayFromStringEquivalent(FileLoader.readShape(lArr[d]));
				
				var boundRect:Array = Helper.getLineArtBoundingRectangle(shapeArr);
				
				var shapeWid:Number = getWidth(boundRect);
				var shapeHei:Number = getHeight(boundRect);
				
				trace("shapewid: ",shapeWid,"ShapeHeight: ",shapeHei);
				
				var sk:DSketch = new DSketch(shapeArr, 0xFF0000,.2/Hinfo_Sushil[lArr[d]+"_relSpeed"], [], [], [], false,20);
				
				var spr:Sprite = new Sprite();
				addChild(spr);
				
				//Drawing.drawRectangle(spr, shapeHei, shapeWid,0,0,false,0xABCDEF,0,1,.4);
				
				spr.addChild(sk);

	            sk.x =-boundRect[0].x;
				sk.y =-boundRect[0].y;
				
				spr.x = lastDrawPos+Hinfo_Sushil[lArr[d]+"_horizontalDisplacement"];
				spr.y = -shapeHei+Hinfo_Sushil[lArr[d]+"_verticalDisplacement"];
				lastDrawPos += shapeWid+Hinfo_Sushil[lArr[d]+"_horizontalDisplacement"];
				fontAr.push(sk);
			//
			}
			
			Helper.addBackToBackDependency(seq, fontAr);
			
			 fontAr[fontAr.length-1].addEventListener(YTEvent.FINISHED, onFin);
		}
		
		
		private function getWidth(bRect:Array):Number
		{
				var wid:Number = bRect[1].x - bRect[0].x;
				return wid;
		}
		
			private function getHeight(bRect:Array):Number
		{
				var hei:Number = bRect[2].y - bRect[1].y;
				return hei;
		}
		
		private function onFin(e:Event):void 
		{
				this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			stop();
		}
		
		public function step():void
		{
			if (!canStep)
			return;
			
			seq.step();
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