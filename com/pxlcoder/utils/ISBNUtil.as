package com.pxlcoder.utils {
	
	public class ISBNUtil {

		public function ISBNUtil() {
		    trace("Running ISBNUtil by PXL Coder." + "\n");
		}
		
		public function isISBN13Valid(isbn:String):Boolean {
		    var ch:int = 0;
		    for (var i:int = 0; i < 12; i += 2) {
			ch += Number(isbn.substring(i, i + 1));
                    }    
                    for (var m:int = 1; m < 12; m += 2) {
                        ch += Number(isbn.substring(m, m + 1)) * 3;
                    }
                    ch += Number(isbn.substring(12));
                    return ch % 10 == 0 && isbn.length == 13;
		}
		
		public function isISBN10Valid(isbn:String):Boolean {
		    var a:int = 0;
	            var b:int = 0;
		    for(var i:int = 0; i < 10; i++){
		        a += Number(isbn.substring(i, i + 1))
		        b += a;
	            }
	            return b % 11 == 0 && isbn.length == 10;
		}
		
		public function convertISBN(isbn:String, autoPad:Boolean = true){
		    var begin:String = "978";
		    var simplify:String = simplifyISBN(isbn);
	            var cut:String;
		    var newISBN:String;
		    if(simplify.length == 10){
			 cut = simplify.substring(0, simplify.length - 1);
			 var partial:String = begin + cut;
			 for(var i:int = 0; i < 10; i++){
			    if(isISBN13Valid(partial + String(i))){
				newISBN = partial + String(i);
			    }
		         }
		    }else if(simplify.length == 13){
			 cut = simplify.substring(3, simplify.length - 1);
			 for(var n:int = 0; n < 10; n++){
			    if(isISBN10Valid(cut + String(n))){
				newISBN = cut + String(n);
		            }
			}
		    }
		    if(autoPad){
			newISBN = padISBN(newISBN);
		    }
			return newISBN;
		}
		
		public function padISBN(isbn:String):String {
		     var newISBN:String;
	             var stringArray:Array;
		     var dash:String = "-";
		     if(isbn.length == 10){
			stringArray = [isbn.substring(0,1), isbn.substring(1,5), isbn.substring(5,9), isbn.substring(9,10)];
			newISBN = stringArray[0] + dash + stringArray[1] + dash + stringArray[2] + dash + stringArray[3];
		     }else if(isbn.length == 13){
			stringArray = [isbn.substring(0,3), isbn.substring(3,4), isbn.substring(4,8), isbn.substring(8,12), isbn.substring(12,13)];
			newISBN = stringArray[0] + dash + stringArray[1] + dash + stringArray[2] + dash + stringArray[3] + dash + stringArray[4];
		     }
		     return newISBN;
		}
		
		public function simplifyISBN(isbn:String):String {
		     var newISBN:String = isbn.split("-").join("");
		     return newISBN;
		}
	}
}