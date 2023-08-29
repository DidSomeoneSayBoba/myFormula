    //
//  postfix calc.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 8/5/17.
//  Copyright © 2017 Aurelia Miyajima. All rights reserved.
//

import Foundation
func postfixcalc(_ formula:String)->Double{
    var final = 0.0
    var tempnum = 0.0
    var opers:[String] = ["+","-","/","*"]
    var formulachars = Array(formula)
    var digits = ["0","1","2","3","4","5","6","7","8","9"]
    var ignorefirst = false
    var chararray:[String] = []
    for char in formulachars {
        chararray.append(String(char))
    }
    //here we go.
    //i mean im gonna split this array.
    var things = chararray.split(separator: " ")
    var temp = 0
    var tempstr = ""
    if things.first?.first == "0"{
    ignorefirst = true
        things.remove(at: 0)
    }
    for thing in things {
        var number = false
        var operate = false
        if digits.contains(thing.first!){
            number = true
        }
        else{
            operate = true
        }
        
        for thin in Array(thing){
            if number == true{
            tempstr += thin
            }
        }
        
    }
    print(things)
    return final
}
func postfixEvaluate(equation1: String) -> Double {
    var tempstr = ""
    var digits = ["0","1","2","3","4","5","6","7","8","9"]
   /* var formulachars = equation1.characters
    var chararray:[String] = []
    for char in formulachars {
        chararray.append(String(char))
    }
    //here we go.
    //i mean im gonna split this array.
    var things = chararray.split(separator: " ")
    var temp = 0
    var tempstr = ""
    if things.first?.first == "0"{
        
        things.remove(at: 0)
    }
    var equation = ""
    for thing in things{
        for w in thing{
        equation+=w
        }
    }*/
    var equation = equation1
    //equation = equation.replacingOccurrences(of:" ", with: "")
   print("equation is \(equation)")
    var result = 0.0
    var stack = Stack<Double>()
    for item in Array(equation) {
        if item == " " || item == "+" || item == "-" || item == "/" || item == "*" || item == "^" || item == "@" || item == "$" || item == "%" || item == "?" || item == "√"{
        if tempstr != ""{
            if tempstr.contains("."){
                stack.push(Double(tempstr)!)
            }
            else{
                stack.push(Double(Int(tempstr)!))
            }
            tempstr = ""
        }
        }
        if item == "+" {
                        if stack.count >= 2 {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                result = val1 + val2
                stack.push(result)
            }
        }
        
        else if item == "$" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                if val1 == 1{
                    result = sin(val2)
                }
                else if val1 == 2{
                    result = cos(val2)
                }
                else if val1 == 3{
                    result = tan(val2)
                }
                else if val1 == 4{
                    result = sin(val2)*(180/Double.pi)
                }
                else if val1 == 5{
                    result = cos(val2)*(180/Double.pi)
                }
                else if val1 == 6{
                 result = tan(val2)*(180/Double.pi)
                }
                stack.push(result)
            }
        }
        else if item == "?" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                result = log(val2)/log(val1)
                
                stack.push(result)
            }
        }
        else if item == "-" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                result = val1 - val2
                stack.push(result)
            }
        } else if item == "*" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                result = val1 * val2
                stack.push(result)
            }
        } else if item == "^" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                result = pow(val1,val2)
                stack.push(result)
            }
        } else if item == "@" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                let thing = 1/val1
                result = pow(val2,thing)
                stack.push(result)
            }
        }else if item == "/" {
            if !stack.isEmpty {
                let val2 = stack.pop()!
                let val1 = stack.pop()!
                result = val1 / val2
                stack.push(result)
            }
        } else {
            if digits.contains(String(item)){
                tempstr += String(item)
            }
            if String(item) == "."{
            tempstr += String(item)
            }
            print("tempstr at \(item) is \(tempstr)")
            
        }
    }
    print(result)
    return result
    
}
