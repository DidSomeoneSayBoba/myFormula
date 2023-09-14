//
//  equationparserwithtwoindexthings.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 7/17/17.
//  Copyright © 2017 Aurelia Miyajima. All rights reserved.
//

import Foundation
//Formula Class
//a format to allow calculations after loading from save
//inputs format
// output format
// outputlist format
class Formulae: NSObject, NSCoding{
    var inputs:[String] = []
    var formula:String = ""
    var outputs:[String] = []
    var name:String = ""
    var output = ""
    var outputlist:[String] = []
    var id = -1
    func run2(_ inputs:[Double])->String{
        let pi = 3.14159265358979323
        let digits = CharacterSet.decimalDigits
        let opers:[String] = ["+","-","/","*"]
        var ischar = false
        
        var operators:[String] = []
        var numbers:[Double] = []
        var entireformula:[String] = []
        var formula = Array(self.formula)
        var forformula = formula
        var index = 0
        var iss = false
        var isi = false
        var isafterequal = false
        var inputindex = 0
    var final = ""
        for char in formula {
            print("index\(index)")
            print("indexvalue\(formula[index])")
            if String(char) == "い"{
                print("inputindex\(inputindex)")
                final += String(inputs[inputindex])
                
                inputindex += 1
                }
                else{
                    if String(char) == "="{
                    isafterequal = true
                    }
                    if isafterequal == false && String(char) != "="{
                final += String(char)
                    }
            
                }
            index+=1
            }
        
        
        
      print("final is currently \(final)")
        print("postfix is \(infixtopostfix(final))")
        
       return infixtopostfix(final)
    }
    func equationMeme(_ inputs:[String])->String{
        var inputs2:[String] = []
        for thing in inputs{
            if thing == "p"{
                inputs2.append("π")
            }
            else{
                inputs2.append(thing)
            }
        }
        var pi = 3.14159265358979323
        let digits = CharacterSet.decimalDigits
        var opers:[String] = ["+","-","/","*"]
        
        var operators:[String] = []
        var numbers:[Double] = []
        var entireformula:[String] = []
        var formula = Array(self.formula)
        var forformula = formula
        var index = 0
        var iss = false
        var isi = false
        var outputindex = 0
        var inputindex = 0
        var final = ""
        for char in formula {
            if String(char) == "い"{
                final += String(inputs2[inputindex])
                /*
                 if String(inputs[inputindex]).characters.count>1{
                 var index1 = 0
                 var numberstring = ""
                 var charray:[Character] = []
                 for char in String(inputs[inputindex]).characters{
                 numberstring += String(char)
                 charray.append(char)
                 /*}
                 var index2 = 0
                 for char1 in charray{
                 
                 if index2 == 0{
                 forformula[index] = char1
                 }
                 else{
                 forformula.insert(char1,at:index)
                 print("i think i screwed up, cuz infix is \(formula) but postfix is \(forformula)")
                 index+=1
                 }
                 index2+=1
                 
                 }
                 index1 = 0*/
                 
                 }*/
                inputindex += 1
            }
            else{
                if String(char) == "お"{
                    
                }
                else{
                    final += String(char)}
            }
            
        }
        index+=1
        return final
    }
    func toEquation(_ inputs:[Double]) ->String{
        var pi = 3.14159265358979323
        let digits = CharacterSet.decimalDigits
        var opers:[String] = ["+","-","/","*"]
        
        var operators:[String] = []
        var numbers:[Double] = []
        var entireformula:[String] = []
        var formula = Array(self.formula)
        var forformula = formula
        var index = 0
        var iss = false
        var isi = false
        var outputindex = 0
        var inputindex = 0
        var final = ""
        for char in formula {
            if String(char) == "い"{
                final += String(inputs[inputindex])
                inputindex += 1
            }
            else{
                if String(char) == "お"{
                   
                }
                else{
                    final += String(char)}
            }
            
        }
        index+=1
        return final
    }
    func run(_ inputs:[Int]) -> Int{
        var result:Int = 0
        let digits = CharacterSet.decimalDigits
        var finalString = Array(formula)
        var index = 0
        var indexofinputs = 0
        var temp = 0
        var parenthesisinputs:[Int] = []
        var parenthesisindexes:[Int] = []
        var parenthesisstring = ""
        var parenthesisstart = false
        var parenthesisend = false
        var parenthesisresults = 0
        var signisadd = false
        var signissubtract = false
        var signismultiply = false
        var signisdivide = false
        for character in finalString{
            /*if parenthesisstart == true{
             if String(character) == ")"{
             for index in parenthesisindexes{
             finalString.remove(at:index)
             }
             var tempformula = StringtoFormula(Formula: parenthesisstring+"=o")
             
             temp = tempformula.run(parenthesisinputs)
             }
             else{
             parenthesisindexes.append(indexofinputs)
             print(parenthesisstring)
             if String(character) == "い"{
             parenthesisinputs.append(inputs[indexofinputs])
             parenthesisstring += "a"
             
             }
             else{
             parenthesisstring += String(character)
             }
             }
             }
             
             else{*/
            print(result)
            if String(character) == "("{
                //finish, restart after saving parenthesis start to parenthesis end and doing that first or just run what's inside them
                parenthesisstart = true
            }
            if String(character) == "+"{
                signisadd = true
                print("sign is add")
            }
            if String(character) == "-"{
                signissubtract = true
                print("sign is sub")
            }
            if String(character) == "*"{
                signismultiply = true
                print("sign is *")
            }
            if String(character) == "/"{
                signisdivide = true
                print("sign is /")
            }
            
            
            if String(character) == "い"{
                print("at input")
                temp = inputs[indexofinputs]
                if result == 0{
                    result = inputs[indexofinputs]
                    print("result was 0 so i changed it to myself")
                }
                
                
                
                if signisadd == true{
                    result += temp
                    print("added to results")
                }
                if signismultiply == true{
                    result = result*temp
                    print("multiplied result to temp")
                }
                if signissubtract == true{
                    result = result - temp
                    print("subbed temp from result")
                }
                if signisdivide == true{
                    result = result/temp
                    print("divided result by temp")
                }
                
                
                indexofinputs+=1
            }
            if digits.contains(UnicodeScalar(String(character))!){
                if result == 0{
                    result = Int(String(character))!
                }
                temp = Int(String(character))!
                if signisadd == true{
                    result += temp
                }
                if signismultiply == true{
                    result = result*temp
                }
                if signissubtract == true{
                    result = result - temp
                }
                if signisdivide == true{
                    result = result/temp
                }
                
            }
            index += 1
            
            //}
        }
        print(result)
        return result
    }
    func toEquation1() ->String{
        var pi = 3.14159265358979323
        let digits = CharacterSet.decimalDigits
        var opers:[String] = ["+","-","/","*"]
        
        var inputs2:[String] = []
        for char in self.inputs{
            if char == "p"{
                inputs2.append("π")
            }
            else{
                inputs2.append(char)
            }
        }
        var operators:[String] = []
        var numbers:[Double] = []
        var entireformula:[String] = []
        var formula = Array(self.formula)
        var forformula = formula
        var index = 0
        var iss = false
        var isi = false
        
        var inputindex = 0
        var final = ""
        for char in formula {
            if String(char) == "い"{
                final += inputs2[index]
                index+=1
                /*
                 if String(inputs[inputindex]).characters.count>1{
                 var index1 = 0
                 var numberstring = ""
                 var charray:[Character] = []
                 for char in String(inputs[inputindex]).characters{
                 numberstring += String(char)
                 charray.append(char)
                 /*}
                 var index2 = 0
                 for char1 in charray{
                 
                 if index2 == 0{
                 forformula[index] = char1
                 }
                 else{
                 forformula.insert(char1,at:index)
                 print("i think i screwed up, cuz infix is \(formula) but postfix is \(forformula)")
                 index+=1
                 }
                 index2+=1
                 
                 }
                 index1 = 0*/
                 
                 }*/
                inputindex += 1
            }
            else if String(char) == "お"{
            final += "(o)"
            }
            else{
                final += String(char)
            }
            
        }
        
        
        return final
    }
    init(inputs:[String], formula:String, name:String){
        self.inputs=inputs
        self.formula = formula
        self.name=name
    }
    required init?(coder aDecoder: NSCoder) {
        
        self.name = (aDecoder.decodeObject(forKey: "name") as? String)!;
        self.inputs = (aDecoder.decodeObject(forKey: "inputs") as? [String])!;
        self.formula = (aDecoder.decodeObject(forKey: "formula") as? String)!;
    }
    
    func encode(with: NSCoder) {
        with.encode(self.name, forKey: "name");
        with.encode(self.inputs, forKey: "inputs");
        with.encode(self.formula, forKey: "formula");
    }
}
//Array of Formulas



