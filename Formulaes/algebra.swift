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
func whichSide(_ equation:Formulae,_ thvar:Int)->Bool{
    if thvar<=equation.inputs.count{
        //true when before equal false when
        var count = 0
        var index = 0
        var charlist = [equation.formula]
        var beforeequal = true
        var thing = false
        for char in charlist{
            if char == "い"
            {
                count += 1
                if beforeequal&&(count==thvar){
                    thing = true;
                }
                if !beforeequal&&(count==thvar){
                    thing = false
                }
            }
            
            index += 1
        }
        return thing
    }
    else{
        return false
    }
   
}
//equation formula thing is not gonna have good thigns because the other side is gonna be (o)s
func specVar(_ equation:Formulae,_ thvar:Int)->String{
    var final = "";
    if thvar<=equation.inputs.count{
        //true when before equal false when
        var count = 0
        var index = 0
        
        var charlist = [equation.formula]
        var beforeequal = true
       
        for char in charlist{
            if char == "い"
            {
                count += 1
                if count==thvar{
                    final+="ぽ"
                }
                else{
                    final+=char
                }
            }
            else{
            final+=char
            }
            index += 1
        }
        return final
    }
    
    else{
        return final
    }
    
}

