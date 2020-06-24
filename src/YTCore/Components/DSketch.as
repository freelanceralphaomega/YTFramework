package YTCore.Components 
{
	import YTCore.Abstract.Math.COMMON.MathFunction;
	import YTCore.Abstract.Math.COMMON.UtilMathFunction;
	import YTCore.Animators.PropertyChanger;
	import YTCore.Animators.Sequencer;
	import YTCore.Components.Templates.LineDrawing;
	import YTCore.Events.YTEvent;
	import YTCore.Utils.Helper;
	import starling.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class DSketch extends Sprite implements IRenderable 
	{
		private var mlineArtArr:Array;
		private var mlineCol:uint;
		private var mdrawTime:Number;
		private var mlineWid:Number;
		private var mdrawParallel:Boolean;
		private var mshapeColArr:Array;
		private var mbodyAlphaArr:Array;
		private var mtextureArr:Array;
		
		private var canStep:Boolean = false;
		
		private var lDrawing:LineDrawing;
		private var pshape:PolygonShape;
		private var pchange:PropertyChanger;
		
		private var penL:Sprite;
		
		private var seq:Sequencer = new Sequencer();
		
		public function DSketch(lineArtArr:Array,lineCol:uint,drawTime:Number,shapeColArr:Array,bodyAlphaArr:Array,textureArr:Array,drawParallel:Boolean=false,lineWid:Number=1,p:Sprite=null) 
		{
			super();
			
			mlineArtArr = lineArtArr;
			mlineCol = lineCol;
			mdrawTime = drawTime;
			mlineWid = lineWid;
			mdrawParallel = drawParallel;
			mshapeColArr = shapeColArr;
			mbodyAlphaArr = bodyAlphaArr;
			mtextureArr = textureArr;
			penL = p;
			
			
			
			lDrawing = new LineDrawing(lineArtArr, drawTime, drawParallel, lineCol, mlineWid,penL);
			
			
			
			pshape = new PolygonShape(lineArtArr, mshapeColArr, [], bodyAlphaArr, mtextureArr); 
			
			pshape.alpha = 0;
			
			
			addChild(lDrawing);
			addChild(pshape);
			pchange = new PropertyChanger(pshape, "alpha", 1.5, 0, 1, UtilMathFunction.LINEAR, UtilMathFunction.LINEAR_INV, [.5,2]);
			
			
			
			
			//Helper.addBackToBackDependency(seq, [lDrawing, pchange]);
			
			seq.initSequence([[lDrawing,0]]);
			
			
            lDrawing.addEventListener(YTEvent.FINISHED, onFin);
			
			
		}
		
		public function set pen(p:Sprite ):void
		{
			penL = p;
		}
		
		private function onFin(e:YTEvent):void 
		{
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			stop();
		}
		
		
		
		private function setup():void
		{
			
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