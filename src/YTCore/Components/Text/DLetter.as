package YTCore.Components.Text 
{
	import YTCore.Animators.Sequencer;
	import YTCore.Components.DSketch;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import com.flashSpider.Graphics.Drawing;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DLetter extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var seq:Sequencer = new Sequencer();
		private var boundRect:Sprite = new Sprite();
		private var fontHolder:Sprite = new Sprite();
		private var ds:DSketch;
		
		public function DLetter(fontFamily:Class,letter:String,lineCol:uint,fillCol:uint,fillAlpha:Number,texture:Sprite,drawTime:Number=2,size:Number=10) 
		{
			super();
			
			
			var bRect:Array = Helper.getLineArtBoundingRectangle(fontFamily[letter]);
			var wid:Number = bRect[1].x - bRect[0].x+20;
			var hei:Number = bRect[2].y - bRect[1].y; 
			
		
			
			addChild(boundRect);
			addChild(fontHolder);
			
			boundRect.alpha = 0;
			
			Drawing.drawRectangle(boundRect, hei, wid,bRect[0].y,bRect[0].y,true,0xFFFFFF);
			
			var fillArr:Array = [];
			var alphaArr:Array = [];
			var textureArr:Array = [];
			
			for (var d:int = 0; d < 10; d++ )
			{
				fillArr.push(fillCol);
				alphaArr.push(fillAlpha);
				textureArr.push(texture);
			}
			
			ds = new DSketch(fontFamily[letter], lineCol, drawTime, fillArr, alphaArr, textureArr, true, 5);
			fontHolder.addChild(ds);
			
			seq.initSequence([[ds, 0]]);
			
			ds.addEventListener(YTEvent.FINISHED, onFin);
			
		}
		
		private function onFin(e:YTEvent):void 
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
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