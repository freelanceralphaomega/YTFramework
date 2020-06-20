package YTCore.Components.Text.NaturalHW.HWInfo 
{
	/**
	 * ...
	 * @author Sushil
	 */
	public class CharacterInfo 
	{
		
		public function CharacterInfo() 
		{
			
		}
		
		public static function symbolName(sym:String):String
		{
			switch(sym)
			{
				case "!":
					return "excl";
					break;
				case "@":
					return "atr";
					break;
				case "#":
					return "hash";
					break;
				case "$":
					return "dollar";
					break;
				case "%":
					return "pct";
					break;
				case "*":
					return "star";
					break;
				case "(":
					return "lparan";
					break;
				case ")":
					return "rparan";
					break;
				case "'":
					return "squote";
					break;
				case "-":
					return "minus";
					break;
				case "+":
					return "plus";
					break;
				case "=":
					return "eql";
					break;
				case "{":
					return "lcurly";
					break;
				case "}":
					return "rcurly";
					break;
				case "[":
					return "lbracket";
					break;
				case "]":
					return "rbracket";
					break;
				case "?":
					return "qmark";
					break;
				case "<":
					return "langle";
					break;
				case ">":
					return "rangle";
					break;
				case ",":
					return "comma";
					break;
				case "/":
					return "frontslash";
					break;
				case "\\":
					return "backslash";
					break;
				case "\"":
					return "dquote";
					break;
				case "|":
					return "pipe";
					break;
				case ";":
					return "semicolon";
					break;
					case "^":
					return "hat";
					break;
				case "0":
					return "N_0";
					break;
								case "1":
					return "N_1";
					break;
								case "2":
					return "N_2";
					break;
								case "3":
					return "N_3";
					break;
								case "4":
					return "N_4";
					break;
								case "5":
					return "N_5";
					break;
								case "6":
					return "N_6";
					break;
								case "7":
					return "N_7";
					break;
								case "8":
					return "N_8";
					break;
								case "9":
					return "N_9";
					break;
				
				
			}
			return sym;
		}
		
	}

}