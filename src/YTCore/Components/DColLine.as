package YTCore.Components 
{
	import YTCore.Interface.IRenderable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DColLine implements IRenderable 
	{
		
		private var canDoStep:Boolean = false;
		
		
		public function DColLine(from:Point,to:Point,colArr:Array,time:Number=5,lWid:Number=1,lwidEnd:Number=-1,doBleed:Boolean=false,bt:Number=1,initAlpha:Number=1,endAlpha:Number=1,isDotted:Boolean=false,texture:Sprite=null) 
		{
			
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
			if (!canDoStep)
			return;
			
			
		}
		
		public function stop():void 
		{
			canDoStep = false;
		}
		
		public function start():void 
		{
			canDoStep = true; 
		}
		
	}

}