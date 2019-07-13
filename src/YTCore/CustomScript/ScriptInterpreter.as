package YTCore.CustomScript 
{
	 import YTCore.Abstract.Math.COMMON.UtilMathFunction;
	 import YTCore.Animators.PathTraverser;
	 import YTCore.Animators.PropertyChanger;
	 import YTCore.Animators.Sequencer;
	 import YTCore.Components.GraphPaper;
	 import YTCore.CustomScript.ScriptClassifier.CircleScript;
	 import YTCore.CustomScript.ScriptClassifier.GraphScript;
	 import YTCore.CustomScript.ScriptClassifier.LineScript;
	 import YTCore.CustomScript.ScriptClassifier.PtConnectScript;
	 import YTCore.CustomScript.ScriptClassifier.SketchScript;
	 import YTCore.CustomScript.ScriptClassifier.TextScript;
	 import YTCore.CustomScript.ScriptWrapper.ScrWrapper;
     import YTCore.Interface.IRenderable;
	 import flash.display.DisplayObject;
	 import flash.display.Sprite;
	 import flash.events.EventDispatcher;
	 import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Sushil Mandi
	 */
	public class ScriptInterpreter extends Sprite implements IRenderable 
	{
		private var canStep:Boolean = false;
		private var scriptArr:Array;
		
		private var seqArr:Array = [];
		private var seq:Sequencer = new Sequencer();
		
		
		private var register:Dictionary = new Dictionary();  
		
		
		private var idArr:Array = [];
		
		public function ScriptInterpreter()  
		{
			
			scriptArr = ScriptManager.getCode();
		
			
			setup();
			
				
		}
		
		//For testing purpose, need to be changed... 
		private function setup():void
		{
			
			for (var d:int = 0; d < scriptArr.length; d++ )
			{
		    var scrObj:Object = scriptArr[d];
			
			
			var scrL:IRenderable;
			
		
			
			switch((scrObj.context as String).toUpperCase())
			{
				case "LINE":
					scrL = new ScrWrapper(LineScript,scrObj.script, scrObj.exe, scrObj.dispatch);
					register[scrObj.id] = [scrL, scrObj.listener];
					idArr.push(scrObj.id);
				break;
				
			case "CIRCLE":
					scrL = new ScrWrapper(CircleScript,scrObj.script, scrObj.exe, scrObj.dispatch);
					register[scrObj.id] = [scrL, scrObj.listener];
					idArr.push(scrObj.id);
				 break;
			
			case "PTCONNECT":
					scrL = new ScrWrapper(PtConnectScript,scrObj.script, scrObj.exe, scrObj.dispatch);
					register[scrObj.id] = [scrL, scrObj.listener];
					idArr.push(scrObj.id);
				 break;
			
			case "TEXT":
				    trace("ScriptInterpreter: ", "_____________________________________________________|");
					trace(scrObj.script);
					scrL = new ScrWrapper(TextScript,scrObj.script, scrObj.exe, scrObj.dispatch);
					register[scrObj.id] = [scrL, scrObj.listener]; 
					idArr.push(scrObj.id);
				break;
				
			case "GRAPH":
					scrL = new ScrWrapper(GraphScript,scrObj.script, scrObj.exe, scrObj.dispatch);
					register[scrObj.id] = [scrL, scrObj.listener]; 
					idArr.push(scrObj.id);
				break;
			case "SKETCH":
				scrL = new ScrWrapper(SketchScript,scrObj.script, scrObj.exe, scrObj.dispatch);
					register[scrObj.id] = [scrL, scrObj.listener]; 
					idArr.push(scrObj.id);
				break;
			
				
			}
			
			
			//-------------------------Animation Handler---------------------------------------------
			applyAnimationRoutine(scrL as DisplayObject,scrObj.animation);	
			//---------------------------------------------------------------------------------------
			
			
			
			applyProperties(scrObj, scrL as DisplayObject);
			
			
			seqArr.push([scrL, 0]);
			seq.initSequence(seqArr);
			addChild(scrL as DisplayObject);
			}
			
			handleListeners();
			
		}
		
		
		private function applyAnimationRoutine(scrL:DisplayObject,objArr:Array):void
		{
			for (var d:int = 0; d < objArr.length; d++)
			{
			var obj:Object = objArr[d];
			
			var property:String = obj.property;
			var time:Number = obj.time;
			var initVal:Number = obj.initVal;
			var finalVal:Number = obj.finalVal;
			var delay:Number = obj.delay;
			var parr:String = obj.params;
			
			trace("SCRIPTINTERPRETER: ", objArr, "\t", property,"\t",time,"\t",initVal,"\t",finalVal,"\t",delay,"\t",parr);
			
			var paramArr:Array = parr.split("|");
			var fn:String = obj.fn;
			
			var f:Function;
			var f_inv:Function;
			
			switch(fn)
			{
				case "exp":
					f = UtilMathFunction.A_EXP_X;
					f_inv = UtilMathFunction.A_EXP_X_INV;
					break;
				case "linear":
					f = UtilMathFunction.LINEAR;
					f_inv = UtilMathFunction.LINEAR_INV;
					break;
				case "quadratic":
					f = UtilMathFunction.QUADRATIC;
					f_inv = UtilMathFunction.QUADRATIC_INV_1;
					break;
				case "axn":
					f = UtilMathFunction.AXn;
					f_inv = UtilMathFunction.AXn_INV;
					break;
			}
			
			
			
		  var proc:PropertyChanger = new PropertyChanger(scrL, property, time, initVal, finalVal, f, f_inv, paramArr);
		  	seqArr.push([proc, delay]);
			}
		}
		
		
		private function applyProperties(scrObj:Object,obj:DisplayObject):void
		{
			var pa:Array = scrObj.properties;
			
			for (var d:int = 0; d < pa.length; d++)
			{
				var prop:Array = pa[d];
				
				var property:String = /\w+\d*/.exec(prop[0]).toString();
				var value:* = prop[1];
				
				
				try{
				obj[property] = value;
				}catch(e:Error){}
			}
			
		}
		
		public function handleListeners():void
		{
			for (var d:int = 0; d < idArr.length; d++)
			{
				var listenerArr:Array = register[idArr[d]][1];
				
				
				
				
				for (var k:int = 0; k < listenerArr.length; k++)
				{
				
				var slave:IRenderable = register[idArr[d]][0];	
				var master:IRenderable = register[listenerArr[k][0]][0];
				var actName:String = listenerArr[k][2];
				var evtName:String = listenerArr[k][1];
				
				register[master] = [evtName,slave,actName];
				
			
				
				(master as EventDispatcher).addEventListener(ScriptEvent.DISPATCH, function(e:ScriptEvent){
					
				
				
				if (e.data == register[e.currentTarget][0])
				{
				register[e.currentTarget][1].getActionInstance(register[e.currentTarget][2]).start();
				}else
				{
					
				}
					
					
				});
				
				} 
			
			}
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