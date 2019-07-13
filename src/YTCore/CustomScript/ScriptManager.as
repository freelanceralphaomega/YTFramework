package YTCore.CustomScript 
{

	import YTCore.Utils.ExpressionHandler.ExpressionEvaluator;
	import YTCore.Utils.FileManager.FileLoader;
	import YTCore.Utils.Helper;
	import YTCore.Utils.Parser.REGEXP_PATTERN;
	/**
	 * ...
	 * @author ...
	 */
	public class ScriptManager 
	{
		
		public function ScriptManager() 
		{
			
		}
		
		
		
		
		/**
		 * @param src Name of the txt file containing script e.g: script1.txt
		 * @return
		 */
		public static function getCode():Array
		{
			
			
			
			var retArr:Array = [];
			
		   
			
			var contBl:Array = contextBlock(); 
			
			
			
			
			for (var d:int = 0; d < contBl.length; d++)
			{
				 var code:Object = new Object();
				var bl:String = contBl[d];
				
				
				
				var context:String = getContext(bl);
				var id:String = getID(bl);
				var lisn:Array = stringToArray(getListeners(bl));
				var exe:Array = stringToArray(getExecutionSchedule(bl));
				var properties:Array=stringToArray(getProperties(bl));
				var disp:Array = stringToArray(getDispatchSchedule(bl));
				var script:Array = [];
				var anim:Array = getAnimationRoutine(bl);
				
				var scr:Array = getActionBlocks(bl);
				
     
				
				for (var k:int = 0; k < scr.length; k++)
				{
					var p:Array = [];
					var str:String = scr[k];
					
					
					
					var aname:String = getActionName(str);
					var repeat:String = isLocal(str);
					var ss:String = getScript(str);
					
					
					p.push(aname, repeat, ss);
					script.push(p);
				}
				
		
				code.context = context;
				code.id = id;
				code.listener = lisn;
				code.exe = exe;
				code.dispatch = disp;
				code.script = script;
				code.properties = properties;
				code.animation = anim;
				
				
				
				retArr.push(code);
				
			}
			
			return retArr;
			
		}
		
		
		public static function preFormatScript(src:String):String
		{
			
			src = src.replace(/#[\w\d#_\.,:\(\)=\|;\s\-]*#/g, "");
		    src = src.replace(/\![\w\d\!#_,:\(\)=\.\|;\s\-]*\!/g, "");
			
			return src;
		}
		
		
		public static function getIncludedScript(src:String):Array
		{
			
			
			var rExp:RegExp = /include\s*\[\s*\w+[\d\w_\s,]*\s*\]/i;
			
			
			var l:String = rExp.exec(src);
			
			
			
			if (l == null)
			return [];
			
			l =/\[[\d\w\s,]*\s*\]/.exec(l).toString().split(" ").join("").split("\r\n").join("");
			
			l = l.split("[")[1].toString().split("]")[0];
			
		
			var arr:Array = l.split(",");
	
			return(arr);
		}
		
		
		public static function getExecutableScript():String
		{
			var rExp:RegExp = /include\s*\[\s*\w+[\?\d\w_\s,]*\s*\]\s*;?/i;
			var mainScr:String = FileLoader.readMain();
			
			
			
			var incS:Array = getIncludedScript(mainScr);
			
			var incScr:String = combineIncludedScript(incS);
			
			
			mainScr = replaceVariables(mainScr);
			
			
			
			mainScr = preFormatScript(mainScr);
			
			mainScr = mainScr.replace(rExp,"");
			
			incScr = preFormatScript(incScr);
			
			
			
			var exeScr:String = mainScr + incScr;
			
			exeScr = ExpressionEvaluator.evaluateAndReplace(exeScr);
			
			
			
			
			return exeScr;
			
		}
		
		
		private static function combineIncludedScript(scrptNames:Array):String
		{
			var src:String = "";
			
			for (var d:int = 0; d < scrptNames.length; d++ )
			{
				src+=replaceVariables(FileLoader.readScript(scrptNames[d]+".txt"));
			}
			
			return src;
		}
		
		
		
		private static function sortReplaceVarArr(s:Array):Array
		{

        for (var i:int=1 ;i<s.length; i++) 
        {
		
        var temp:Array = s[i]; 
  
        // Insert s[j] at its correct position 
        var j:int = i - 1; 
        while (j >= 0 && temp[0].length > s[j][0].length) 
        { 
            s[j+1] = s[j]; 
            j--; 
        } 
        s[j+1] = temp; 
       } 
      return s;
		}
		
		
		
		
		private static function getVarValArr(src:String):Array
		{
		
			var testReg:RegExp = /\$\w+[\w\d_]*\s*=\s*\$\w[\w\d_\+\-\*\/\$\s]*;/;
			var reg:RegExp = /\$\w+[\w\d_]*\s*=\s*-?[\w\d_.]*;/g;
			var varArr:Array = [];
			var vCodes:Array = [];
			
			
			var m:Object = reg.exec(src);
			
			while (m != null)
			{
				vCodes.push(m);
				m=reg.exec(src);
			}
			
			
			for (var d:int = 0; d < vCodes.length; d++ )
			{
				var mArr:Array;
				var v:Array = ((vCodes[d].toString()).split(" ").join("") as String).split("=");
				var p1:String = v[0];
				var p2:String = v[1].split(";")[0];
				mArr = [p1,p2];
				varArr.push(mArr);
			}
			
			return varArr;
		}
		
		private static function simplifyVarAssignments(src:String):String
		{
		
			var testReg:RegExp = /\$\w+[\w\d_]*\s*=\s*\$\w[\w\d_\+\-\*\/\$\s]*;/;
			var reg:RegExp = /\$\w+[\w\d_]*\s*=\s*-?[\w\d_.]*;/g;
			
			var dependentVarExp:String = testReg.exec(src);
			
			var varArr:Array = getVarValArr(src);
			
			while (dependentVarExp != null)
			{
				
				
				var expr:String = dependentVarExp;
				
				
			for(var n:int = 0; n < varArr.length; n++)
			{
				var k:Array = varArr[n];
				expr = expr.split(k[0]).join(k[1]);
			}
			
			 expr = ExpressionEvaluator.evaluateAndReplace(expr);
			 
			 src = src.split(dependentVarExp.toString()).join(expr);
			 dependentVarExp = testReg.exec(src);
			 
			 varArr = getVarValArr(src);
				
			}
			
			return src;
			
		}
		
		
		
		
		
		public static function replaceVariables(src:String,removeVarAssignment:Boolean=true):String
		{
			
			src = simplifyVarAssignments(src);
			var reg:RegExp = /\$\w+[\w\d_]*\s*=\s*-?[\w\d_.]*;/g;
		    var varArr:Array = varArr = getVarValArr(src);
			
			
			
			
			varArr = sortReplaceVarArr(varArr);
			
		
			if (removeVarAssignment)
			{
			while (reg.test(src))
			{
			src = src.replace(reg, "");
			}
			}
			
			
			
			for (var n:int = 0; n < varArr.length; n++)
			{
				var k:Array = varArr[n];
				src = src.split(k[0]).join(k[1]);
			}
			
			return src;
			
		}
		
		
		
		public static function contextBlock():Array
		{
			
			var testReg:RegExp = REGEXP_PATTERN.BLOCK_EXTRACT;
			var retArr:Array = [];
			var scr:String = getExecutableScript();
			
			
			
			
			var res:Object = REGEXP_PATTERN.BLOCK_EXTRACT.exec(scr); 
		
			//var res:Object = testReg.exec(scr); 
			while (res != null)
			{
				
				retArr.push(res);
				//res = REGEXP_PATTERN.BLOCK_EXTRACT.exec(scr); 
				res = testReg.exec(scr); 
			}
			
			
			return retArr;
		}
		
		
		public static function getActionBlocks(contBl:String):Array
		{
			
			var bl:Array = [];
			var exp:RegExp = /<\s*act\s*:\s*\w+[\w\d_]*\s*>[\s\w\d;,\|'\!\+\?=\.:_\-(\)]*<\s*end\s*:\s*\w*\s*>/ig;
			var str:Object = exp.exec(contBl);
			
			while (str != null)
			{
				bl.push(str);
				str =  exp.exec(contBl);
			}
			
			
			return bl;
		}
		
		
		public static function getActionName(actBl:String):String
		{
			
			var exp:RegExp = /:\s*\w+[\w\d_]*\s*[^>]/i;
			var l:String = (exp.exec(actBl));
			var m:String = /[^:\s].*/.exec(l);
			return(m);
		}
		
		public static function getScript(actionBl:String):String
		{
			
			var exp:RegExp = />[^<]*/i;
			var l:String = exp.exec(actionBl);
			
			var exp2:RegExp = /[^>][\w\d\s;'=\+\!\?\|\@\.\(\):,_]*/;
			
			return exp2.exec(l);
			
		}
		
		public static function isLocal(actionBl:String):String
		{
			
			
			var exp:RegExp = /<\s*end\s*:\s*\w*/i;
			var l:String = exp.exec(actionBl);
			
		
			
			var exp2:RegExp = /:\s*\w*/i;
			var m:String = exp2.exec(l);
			
			var exp3:RegExp = /[^:].*/i;
			var q:String = exp3.exec(m);
			
			return q;
		}
		
		
		public static function getContext(cont:String):String
		{
			var l:String = /CONTEXT\s*:\s*\w[\w\d_]*/i.exec(cont);
			var m:String = /:\s*\w[\w\d_]*/.exec(l);
			var f:String = /\w[\w\d_]*/.exec(m);
			
			return f;
		}
		
		
		public static function getID(contextBl:String):String
		{
			var l:String = (/ID\s*:\s*\w[\w\d_]*\s*;/i.exec(contextBl));
			var m:String = /:\w[\w\d_]*/.exec(l);
			var f:String = /\w[\w\d_]*/.exec(m);
			return f;
		}
		
		public static function getAnimationRoutine(contextBl:String):Array
		{
			
			var arr1:Array = [];
			var retArr:Array = [];
			var retObj:Object = new Object();
			var exp:RegExp = /animation\s*:\s*.*;/ig;
			
			var l:Object = exp.exec(contextBl);
			
			
			
			while (l != null)
			{
				arr1.push(l);
				l= exp.exec(contextBl);
			}
			
		
			
            for (var d:int = 0; d < arr1.length; d++)
			{
			var f:String = /\(\s*[\-\s \w:,\.\d_\|;]*\s*\)\s*;/.exec(arr1[d]);
			var f1:String = /[^\(][\-\w\|\.\d_:,]*/.exec(f);
			f1 = f1.split(" ").join("");
			
			
			
			var obj:Object = Helper.getObjectFromString(f1);
			retArr.push(obj);
			}
			
			
			
			return retArr;
		}
		
		public static function getExecutionSchedule(contextBl:String):String
		{
			var exp:RegExp = /exe\s*:\s*.*;/i;
			
			var l:String = exp.exec(contextBl);
			
			
			var m:String = /:\s*[\s\(\),\.\w\d_]*;/.exec(l);
			
			var f:String = /[^:]\s*[\s\(\),\.\w\d_]*/.exec(m);
			
			
			return f;
		}
		
		public static function getProperties(contextBl:String):String
		{
			
			var exp:RegExp = /properties\s*:\s*.*;/i;
			
			var l:String = exp.exec(contextBl);
			
			
			var m:String = /:\s*[\s\(\),-\.\w\d_]*;/.exec(l);
			
			var f:String = /[^:]\s*[\s\(\),-\.\w\d_]*/.exec(m);
			
			
			return f;
		}
		
		
		public static function getDispatchSchedule(contextBl:String):String
		{
			var exp:RegExp = /dispatch\s*:\s*.*;/i;
			
			var l:String = exp.exec(contextBl);
			
			var m:String = /:\s*[\s\(\),\w\d_]*;/.exec(l);
			
			var f:String = /[^:]\s*[\s\(\),\w\d_]*/.exec(m);
			
			return f;
		}
		
		public static function getListeners(contextBl:String):String
		{
			var exp:RegExp = /listen\s*:\s*.*;/i;
			
			var l:String = exp.exec(contextBl);
			
			var m:String = /:\s*[\s\(\),\w\d_]*;/.exec(l);
			
			var f:String = /[^:]\s*[\s\(\),\w\d_]*/.exec(m);
			
			return f;
		}
		
		public static function stringToArray(str:String):Array
		{
			var finalArr:Array = [];
			var strArr:Array = [];
			
			str = str.split(" ").join("");
			
			var exp:RegExp = /[^\(\)][\w\d,-\._\s]*[^\)\(,\s]/g;
			
			var m:Object = exp.exec(str);
			
			while (m != null)
			{
				strArr.push(m);
				m = exp.exec(str);
			}
			
			
			for (var d:int = 0; d < strArr.length; d++)
			{
				var s:String = strArr[d];
				var a:Array = s.split(",");
				finalArr.push(a);
			}
			
			return finalArr;
		}
		
	}

}