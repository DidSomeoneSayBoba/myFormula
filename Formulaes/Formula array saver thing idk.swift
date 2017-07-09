//
//  Formula array saver thing idk.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 7/2/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import Foundation
//String into usable formula
func StringtoFormula(Formula:String) ->Formulae{
    //want to put string into formula form, with ,s between formula and inputs
    var charsinformula = Formula
    var inputs1:[String]=[]
    var formulastring:String=""
    let letters = CharacterSet.letters
    let digits = CharacterSet.decimalDigits
    let greekletters = CharacterSet.init(charactersIn:"ΑαΒβΓγΔδΕεϜϝΖζΗηΘθΙιΚκΛλΜμΝνΞξΟοΠπΡρΣσςΤτΥυΦφΧχΨψΩω")
    let sqrt = CharacterSet.init(charactersIn:"√")
    var letterCount = 0
    var digitCount = 0
    var greekCount = 0
    //finalString has variables replaced with japanese letters with numbers for lolsははははは
    var beforeequal = true
    var finalString = Array(charsinformula.characters)
    var finalString1 = Array(charsinformula.characters)
    var indexforabovestring = 0
    for uni in charsinformula.unicodeScalars {
        if(beforeequal == true){
            if letters.contains(uni) {
                letterCount += 1
                var strofcharatindex = String(finalString[indexforabovestring])
                inputs1.append(strofcharatindex)
                formulastring+="い"
            } else if digits.contains(uni) {
                digitCount += 1
                formulastring+=String(finalString[indexforabovestring])
            }else if greekletters.contains(uni) {
                greekCount += 1
                formulastring+=String(finalString[indexforabovestring])
            }
            else if sqrt.contains(uni){
                formulastring+=String(finalString[indexforabovestring])
            }
            else if String(finalString[indexforabovestring]) == "="{
                beforeequal = false
                formulastring+="="
            }
            else {
                formulastring+=String(finalString[indexforabovestring])
            }
            
        }
        else{
            formulastring+="お"
        }
        indexforabovestring+=1
        
    }
    print(Formula+" is "+formulastring)
    let formula = Formulae(inputs:inputs1, formula:formulastring)
    return formula
}
//Formula Struct
struct Formulae{
    var inputs:[String]
    var formula:String
    func run(_ inputs:[Int]){
        var result:Int = 0
        let digits = CharacterSet.decimalDigits
        var finalString = Array(formula.characters)
        var index = 0
        var indexofinputs = 0
        var temp = 0
        var signisadd = false
        var signissubtract = false
        var signismultiply = false
        var signisdivide = false
        for character in finalString{
            print(result)
            
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
        }
        print(result)
    }
    
}
//Array of Formulas


    
