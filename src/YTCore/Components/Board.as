package YTCore.Components 
{
	import flash.display.Sprite;
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class Board extends Sprite implements IRenderable 
	{
		
		private var dirtyLayer:Sprite = new Sprite();
		private var clearLayer:Sprite = new Sprite();
		private var drawLayer:Sprite = new Sprite();
		
		private var canvas:Sprite = new Sprite();
		
		private var canStep:Boolean = false;   
		public function Board()
		{
			super(); 
			
		}
		
		
		private function setup():void
		{
			addChild(dirtyLayer);
			addChild(clearLayer);
			addChild(drawLayer);
			
			dirtyLayer.addChild(canvas); 
			
			clearLayer.mask = drawLayer;  
		}
		
		
		public function step():void  
		{
			if (!canStep)
			return;
			
			 
			
		}
		
		public function stop():void  
		{
			
		}
		
		public function start():void 
		{
			
		}
		
	}

}