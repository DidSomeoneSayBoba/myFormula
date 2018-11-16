//
//  algebra.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 10/29/18.
//  Copyright © 2018 Michael Miyajima. All rights reserved.
//

import Foundation
/*
 if there's a variable with operations on it,(specified), recognize and apply its inverse to the opposite side until the variable is
 isolated.
 
 bool checks if lonely
 
 */
func lonelyVar(_ equation:Formulae,_ thvar:Int)->Bool{
    if thvar<=equation.inputs.count{
    var equationthing = equation.inputs[thvar]
        return true
    }
    else{
        return false
    }
    
}
func whichSide(_ equation:String)->Bool{
    print("start of whichSide , false means before, true means after equal sign")
        //true when before equal false when
    
        var index = 0
    
        var charlist = Array(equation)
        var beforeequal = true
        var thing = false
        for char in charlist{
            print(char)
            if char == "ぽ"&&beforeequal == true{
                thing = false
            }
            if char == "ぽ"&&beforeequal == false{
                thing = true
            }
            
            if char == "="{
                beforeequal = false
            }
            index += 1
        }
        return thing
   
   
}
//equation formula thing is not gonna have good thigns because the other side is gonna be (o)s so we gotta make pseudoformulas
func specVar(_ equation:pseudoFormula,_ thvar:Int)->String{
    var final = "";
    print("specvar start, thvar \(thvar)")
    if thvar<=equation.inputs.count+1{
        //true when before equal false when
        var count = 0
        var index = 0
        
        var charlist = Array(equation.formula)
        var beforeequal = true
        print(charlist)
        for char in charlist{
            print("current char \(char)")
            if char == "い"
            {
                print(count)
                if count==(thvar-1){
                    final+="ぽ"
                    print("reached the po")
                }
                else{
                    final+=String(char)
                }
                count += 1
                print("count\(count) when char \(char) at index \(index)")
            }
            else{
                print("lol you aint touchin any Is ")
            final+=String(char)
            }
            index += 1
            print("index in specvar "+"\(index)")
            print("current final \(final)")
        }
        return final
    }
    
    else{
        return final
    }
    
}

