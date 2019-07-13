package YTCore.Components 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Components.Templates.LineArt;
	import YTCore.Graphics.TextureLibrary;
	import YTCore.Utils.Helper;
	import com.flashSpider.Graphics.Drawing;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class PolygonShape extends Sprite 
	{
		private var spr:Sprite = new Sprite();
		
		private var mpolygonArr:Array;
		private var mbodycolArr:Array;
		private var malphaArr:Array;
		private var mlineColArr:Array;
		private var mTextureArr:Array;
		
		/**
		 * 
		 * @param	polygonArr Array of polygons, defined by co-ordinate array e.g: [[[a,b],[c,d],[e,f]],[[a1,b1],[a2,b2]]]
		 * @param	bodycolArr Array of respective fill colors
		 * @param	lineColArr Array of respective boundary colors
		 * @param	alphaArr Array of Alpha values of the fill colors
		 * @param	textureArr Texture of the filling
		 */
		public function PolygonShape(polygonArr:Array,bodycolArr:Array,lineColArr:Array,alphaArr:Array,textureArr:Array) 
		{
			super();
			
			mpolygonArr = polygonArr;
			mbodycolArr = bodycolArr;
			malphaArr = alphaArr;
			mlineColArr = lineColArr;
			mTextureArr = textureArr;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStg);
		}
		
		private function onStg(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStg);
			
			addChild(spr);
			
			var mbCol:uint = 0x000000;
			var mlCol:uint = 0x000000;
			var mAlpha:Number = 1;
			for (var d:int = 0; d < mpolygonArr.length; d++ )
			{
			
			mbCol = 0x000000;
			mlCol = 0x000000;
			mAlpha = 1;
				
				var tempSpr:Sprite = new Sprite();
				
				spr.addChild(tempSpr);
				
				if (mbodycolArr[d])
				mbCol = mbodycolArr[d];
				
				if (mlineColArr[d])
				mlCol = mlineColArr[d];
				
				if (malphaArr[d])
				mAlpha = malphaArr[d];
				
			if(Helper.getDistanceInitEnd(mpolygonArr[d])<=5)
			Drawing.drawPolygon(tempSpr, false, mpolygonArr[d], mbCol, mAlpha, mlCol, 0);
			
			if (mTextureArr[d])
			{
				var mSpr:Sprite = mTextureArr[d];
				spr.addChild(mSpr);
				mSpr.mask = tempSpr;
			
			}
			}
		}
		
	}

}