package YTCore.Animators 
{
	import YTCore.Abstract.Math.COMMON.MathFunction;
	import YTCore.Events.YTEvent;
	import YTCore.Interface.IRenderable;
	import YTCore.Utils.Global;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class PropertyChanger extends EventDispatcher implements IRenderable 
	{
		private var canStep:Boolean = false;
		
		private var mpropertyName:String;
		private var minitVal:Number;
		private var mendVal:Number;
		private var mFn:Function;
		private var mFnInv:Function;
		private var mFnArgs:Array;
		private var mobj:Object;
		private var mtime:Number;
		
		private var valArr:Array;
		
		private var currentFrame:int = 0;
		
		/**
		 * 
		 * @param	obj
		 * @param	propertyName
		 * @param	time
		 * @param	initVal
		 * @param	endVal
		 * @param	Fn
		 * @param	FnInv
		 * @param	FnArgs
		 */
		public function PropertyChanger(obj:Object,propertyName:String,time:Number,initVal:Number,endVal:Number,Fn:Function,FnInv:Function,FnArgs:Array) 
		{
			mobj = obj;
			mpropertyName = propertyName;
			minitVal = initVal;
			mendVal = endVal;
			mFn = Fn;
			mFnInv = FnInv;
			mFnArgs = FnArgs;
			mtime = time;
			
			valArr = MathFunction.getFunctionValuesBetween(initVal, endVal, time * Global.FRAME_RATE, Fn, FnInv, FnArgs, FnArgs); 
		}
		
		
		/* INTERFACE YTCore.Interface.IRenderable */
		
		public function step():void 
		{
		
			if (!canStep)
			return;
	
			mobj[mpropertyName] = valArr[currentFrame];
			currentFrame++;
			
			if (currentFrame >= valArr.length)
			{
			stop();
			this.dispatchEvent(new YTEvent(YTEvent.FINISHED));
			}
			
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