package YTCore.Components 
{
	import YTCore.Abstract.Math.COMMON.MathHandler;
	import YTCore.Animators.Sequencer;
	import YTCore.Events.YTEvent;
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class Plotter extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		
		private var seq:Sequencer = new Sequencer();
		
		private var mptArr:Array;
		private var mcurveCol:uint;
		private var mgWidth:Number;
		private var mgHeight:Number;
		private var mpixelPerUnitX:Number;
		private var mpixelPerUnitY:Number;
		private var morigX:int;
		private var morigY:int;
		private var mstartX:Number;
		private var mendX:Number;
		private var mstartY:Number;
		private var mendY:Number;
		
		
		private var graphPaper:GraphPaper;
		private var lconnect:PointConnector;
		
		/**
		 * 
		 * @param	ptArr Array containing coordinates e.g: [new Point(x1,y1),new Point(x2,y1)]
		 * @param	startX Left most Marking of the graph, in unit being plotted in X axis
		 * @param	endX  Right most Marking of the graph, in unit being plotted in X axis
		 * @param	startY Bottom most Marking of the graph, in unit being plotted in Y axis
		 * @param	endY  Top most Marking of the graph, in unit being plotted in Y axis
		 * @param	pixelPerUnitX How many pixels are required to represent 1 unit along X axis
		 * @param	pixelPerUnitY How many pixels are required to represent 1 unit along Y axis
		 * @param	curveCol Colour of the curve
		 */
		public function Plotter(
		
		ptArr:Array,   
		startX:Number,
		endX:Number,
		startY:Number,
		endY:Number,
		pixelPerUnitX:Number=500/720,
		pixelPerUnitY:Number=500/2,
		curveCol:uint=0x000000     
		      
		) 
		{
			super();
			
		mptArr          = ptArr;        
		mcurveCol       = curveCol;         
		mpixelPerUnitX  = pixelPerUnitX;
		mpixelPerUnitY  = pixelPerUnitY;
		mstartX = startX;
		mendX = endX;
		mstartY = startY;
		mendY = endY;
		
		mgWidth         = mpixelPerUnitX * (mendX-mstartX+.000001);    
		mgHeight        = mpixelPerUnitY * (mendY - mstartY+.0001);
		
		morigX          = -mstartX;       
		morigY          = -mstartY;
		
		
		setup();
		
		}
		
		public function markPoints(pts:Array):void
		{
			graphPaper.plotPoints(pts);
		}
		
		private function setup():void
		{
			
			
			//graphPaper = new GraphPaper(mgWidth, mgHeight, mpixelPerUnitX, mpixelPerUnitY, 50, 1,1, 5,morigX,morigY);
			graphPaper = new GraphPaper(mgWidth, mgHeight, mpixelPerUnitX, mpixelPerUnitY, 50,1,10,10,morigX,morigY,0xFF00FF,0xFF00FF,2,2,0xCCAA22,0xDD1133,15); 
			graphPaper.gridAlpha = .1;
			
			lconnect = new PointConnector(MathHandler.unitToPixelCoordinate(mptArr,mpixelPerUnitX,mpixelPerUnitY), mcurveCol, 3, 2);
			
			
			addChild(graphPaper);
			addChild(lconnect);
			
			seq.register([graphPaper,lconnect]);
			seq.addDependency(graphPaper, lconnect,YTEvent.FINISHED);
			seq.initSequence([[graphPaper,1]]);
		}
		
		/* INTERFACE Interface.IRenderable */
		
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