//
//  shunting yard.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 7/25/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//
/*
import Foundation
import UIKit
struct Stack {
    var array: [String] = []
    // 1
    mutating func push(_ element: String) {
        // 2
        array.append(element)
    }
    // 1
    mutating func pop() -> String? {
        // 2
        return array.popLast()
    }
    func peek() -> String? {
        return array.last
    }
}

let ops = ["+","-","*","/"]
enum Operator{
    case add
    case subtract
    case multiply
    case divide
}

func higherPrec(_ op:String,_ sub:String)->Bool{
var presc1 = 0
    var presc2 = 0
    if ops.contains(op) && ops.contains(sub){
        if(op == "+" || op == "-"){
            presc1 = 2
        }
        if(sub == "+" || sub == "-"){
            presc2 = 2
        }
        if(op == "*" || op == "/"){
            presc1 = 4
        }
        if(sub == "*" || sub == "/"){
            presc2 = 4
        }
    }
    
    
        return presc2>=presc1
    
}
func toStringArray(_ char:[Character])->[String]{
    var finalarray:[String] = []
    for c in char{
        finalarray.append(String(c))
    }
    return finalarray
}
func toPostfix(_ infix:String)->String{
    var postfix:String = ""
    var stack:Stack = Stack(array: (infix.characters.map{ String($0)}))
    
    return postfix
}*/
