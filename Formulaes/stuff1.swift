//
//  stuff1.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 7/28/17.
//  Copyright © 2017 Aurelia Miyajima. All rights reserved.
//

import Foundation

internal enum OperatorAssociativity {
    case leftAssociative
    case rightAssociative
}

public enum OperatorType: CustomStringConvertible {
    case add
    case subtract
    case divide
    case multiply
    case percent
    case exponent
    case root
    case trig
    case log
    public var description: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .divide:
            return "/"
        case .multiply:
            return "*"
        case .percent:
            return "%"
        case .exponent:
            return "^"
        case .root:
            return "@"
        case .trig:
            return "$"
        case .log:
            return "?"
        }
    }
}

public enum TokenType: CustomStringConvertible {
    case openBracket
    case closeBracket
    case Operator(OperatorToken)
    case operand(Double)
    
    public var description: String {
        switch self {
        case .openBracket:
            return "("
        case .closeBracket:
            return ")"
        case .Operator(let operatorToken):
            return operatorToken.description
        case .operand(let value):
            return "\(value)"
        }
    }
}

public struct OperatorToken: CustomStringConvertible {
    let operatorType: OperatorType
    
    init(operatorType: OperatorType) {
        self.operatorType = operatorType
    }
    
    var precedence: Int {
        switch operatorType {
        case .add, .subtract:
            return 0
        case .divide, .multiply, .percent:
            return 5
        case .exponent, .root, .log:
            return 10
        case .trig:
            return 20
        }
    }
    
    var associativity: OperatorAssociativity {
        switch operatorType {
        case .add, .subtract, .divide, .multiply, .percent, .trig, .log:
            return .leftAssociative
        case .exponent, .root:
            return .rightAssociative
        }
    }
    
    public var description: String {
        return operatorType.description
    }
}

func <= (left: OperatorToken, right: OperatorToken) -> Bool {
    return left.precedence <= right.precedence
}

func < (left: OperatorToken, right: OperatorToken) -> Bool {
    return left.precedence < right.precedence
}

public struct Token: CustomStringConvertible {
    let tokenType: TokenType
    
    init(tokenType: TokenType) {
        self.tokenType = tokenType
    }
    
    init(operand: Double) {
        tokenType = .operand(operand)
    }
    
    init(operatorType: OperatorType) {
        tokenType = .Operator(OperatorToken(operatorType: operatorType))
    }
    
    var isOpenBracket: Bool {
        switch tokenType {
        case .openBracket:
            return true
        default:
            return false
        }
    }
    
    var isOperator: Bool {
        switch tokenType {
        case .Operator(_):
            return true
        default:
            return false
        }
    }
    
    var operatorToken: OperatorToken? {
        switch tokenType {
        case .Operator(let operatorToken):
            return operatorToken
        default:
            return nil
        }
    }
    
    public var description: String {
        return tokenType.description
    }
}

public class InfixExpressionBuilder {
    private var expression = [Token]()
    
    public func addOperator(_ operatorType: OperatorType) -> InfixExpressionBuilder {
        expression.append(Token(operatorType: operatorType))
        return self
    }
    
    public func addOperand(_ operand: Double) -> InfixExpressionBuilder {
        expression.append(Token(operand: operand))
        return self
    }
    
    public func addOpenBracket() -> InfixExpressionBuilder {
        expression.append(Token(tokenType: .openBracket))
        return self
    }
    
    public func addCloseBracket() -> InfixExpressionBuilder {
        expression.append(Token(tokenType: .closeBracket))
        return self
    }
    
    public func build() -> [Token] {
        // Maybe do some validation here
        return expression
    }
}

// This returns the result of the shunting yard algorithm
public func reversePolishNotation(_ expression: [Token]) -> String {
    
    var tokenStack = Stack<Token>()
    var reversePolishNotation = [Token]()
    
    for token in expression {
        switch token.tokenType {
        case .operand(_):
            reversePolishNotation.append(token)
            
        case .openBracket:
            tokenStack.push(token)
            
        case .closeBracket:
            while tokenStack.count > 0, let tempToken = tokenStack.pop(), !tempToken.isOpenBracket {
                reversePolishNotation.append(tempToken)
            }
            
        case .Operator(let operatorToken):
            for tempToken in tokenStack.makeIterator() {
                if !tempToken.isOperator {
                    break
                }
                
                if let tempOperatorToken = tempToken.operatorToken {
                    if operatorToken.associativity == .leftAssociative && operatorToken <= tempOperatorToken
                        || operatorToken.associativity == .rightAssociative && operatorToken < tempOperatorToken {
                        reversePolishNotation.append(tokenStack.pop()!)
                    } else {
                        break
                    }
                }
            }
            tokenStack.push(token)
        }
    }
    
    while tokenStack.count > 0 {
        reversePolishNotation.append(tokenStack.pop()!)
    }
    
    return reversePolishNotation.map({token in token.description}).joined(separator: " ")
    
}
func infixtopostfix(_ infix:String)->String{
    var expr = InfixExpressionBuilder()
    let array = Array(infix)
    let digits = ["1","2","3","4","5","6","7","8","9","0","p","K","e","π","φ"]
    let letters = ["A","B","C","D","E","F","G","H","I","J","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","f","g","h","i","j","k","l","m","n","o","q","r","s","t","u","v","w","x","y","z"]
    var tempstr = ""
    var tempnum = 0.0
    var number = false
    var double = false
    var index = 0
    var finalindex = array.count-1
    print("finalindex = \(finalindex)")
    print("infix is \(infix)")
    for char in array {
        if digits.contains(String(char)){
            if index == finalindex{
                print("last value")
                number = false
                double = false
                if String(char) == "π"{
                    if tempstr != ""{
                        expr.addOperand(Double(String(tempstr))!)
                        expr.addOperator(.multiply)

                    }
                    
                    expr.addOperand(Double.pi)

                }
                else if String(char) == "p"{
                    if tempstr != ""{
                        expr.addOperand(Double(String(tempstr))!)
                        expr.addOperator(.multiply)
                        
                    }
                    
                    expr.addOperand(Double.pi)
                    
                }
                else if String(char) == "e"{
                    if tempstr != ""{
                        expr.addOperand(Double(String(tempstr))!)
                        expr.addOperator(.multiply)
                        
                    }
                    
                    expr.addOperand(2.718281828459045235360287471352662497757247093699959549669676277240766303535475945713821785251664274)
                    
                }
                else if String(char) == "K"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)

                        
                    }
                    var boltzmann = 1.38
                    boltzmann = boltzmann*Double((10^(-23)))
                    expr.addOperand(boltzmann)
                    
                }
                else if String(char) == "φ"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)
                        
                        
                    }
                    var boltzmann = sin(54.00)*(180/Double.pi)
                    boltzmann = boltzmann*2
                    expr.addOperand(boltzmann)
                    
                }
                else{
                tempstr+=String(char)
                    expr.addOperand(Double(String(tempstr))!)}
            }
            else{
                if String(char) == "π"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)
                        
                        
                    }
                    
                    
                    expr.addOperand(Double.pi)
                }
               else if String(char) == "p"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)
                        
                        
                    }
                    
                    
                    expr.addOperand(Double.pi)
                }
                else if String(char) == "e"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)
                        
                        
                    }
                    
                    
                    expr.addOperand(2.718281828459045235360287471352662497757247093699959549669676277240766303535475945713821785251664274)
                }
                else if String(char) == "K"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)
                        
                        
                    }
                    var boltzmann = 1.38
                    boltzmann = boltzmann*Double((10^(-23)))
                    expr.addOperand(boltzmann)
                    
                }
                else if String(char) == "φ"{
                    if tempstr != ""{
                        expr.addOperator(.multiply)
                        expr.addOperand(Double(String(tempstr))!)
                        
                        
                    }
                    var boltzmann = sin(54.00)*(180/Double.pi)
                    boltzmann = boltzmann*2
                    expr.addOperand(boltzmann)
                    
                }
            else{
            print("tempstring is \(tempstr) before change")
                number = true
            tempstr+=String(char)
                print("found number \(String(char))")}
            print("tempstring is \(tempstr) right now")}
        }
        if number == true{
            if String(char) == "."{
                double = true
                tempstr+=String(char)
                print("found \(String(char))")
            }
        }
        if String(char) == "+"{
            
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                print("i added number to the thing. \(tempstr) for +")
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                print("i added number to the thing. \(tempstr) for + on num")
                tempstr = ""
            }
            expr.addOperator(.add)
        }
        if String(char) == "-"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                print("i added number to the thing. \(tempstr) for -")
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                print("i added number to the thing. \(tempstr) for - on num")
                tempstr = ""
            }
            expr.addOperator(.subtract)
        }
        if String(char) == "*"{
            
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                print("i added number to the thing. \(tempstr) for -")
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                print("i added number to the thing. \(tempstr) for - on num")
                tempstr = ""
            }
            expr.addOperator(.multiply)
        }
        if String(char) == "$"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.trig)
        }
        if String(char) == "?"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.log)
        }
        if String(char) == "/"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.divide)
        }
        if String(char) == "^"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.exponent)
        }
        if String(char) == "@"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.root)
        }
        if String(char) == "√"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.root)
        }
        if String(char) == "%"{
            if double == true{
                tempnum = Double(tempstr)!
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addOperator(.percent)
        }
        if String(char) == "(" {
            if tempstr == ""{
    
    }
            if double == true{
                print("tempstr open parn\(tempstr)")
                if tempstr == ""{
                }
                else{
                tempnum = Double(tempstr)!
                    tempstr = ""
                }
                number = false
                double = false
                expr.addOperand(tempnum)
                expr.addOperator(.multiply)
                tempstr = ""
            }
            else if number == true && double == false{
                if tempstr == ""{
                }
                else{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                expr.addOperator(.multiply)
                tempstr = ""
                }
            }
            
            expr.addOpenBracket()
        }
        if String(char) == ")" {
            if double == true{
                if tempstr == ""{
                }
                else{
                    tempnum = Double(tempstr)!
                    tempstr = ""
                }
                number = false
                double = false
                expr.addOperand(tempnum)
                tempstr = ""
            }
            else if number == true && double == false{
                number = false
                tempnum = Double(tempstr)!
                expr.addOperand(tempnum)
                tempstr = ""
            }
            expr.addCloseBracket()
        }
        index += 1
    }
    var expr1 = expr.build()
    print("at end of loop, normal thing is \(expr1.description)")
    return reversePolishNotation(expr1)
    
}
func convertEquation(_ equation:String)->String{
    var converted = ""
    
    let characters = Array(equation)
    var thing = 0
    for char in characters{
        if String(char) == "1"{
            
        }
        if String(char) == "2"{
            
        }
        if String(char) == "3"{
            
        }
        if String(char) == "4"{
            
        }
        if String(char) == "5"{
            
        }
        if String(char) == "6"{
            
        }
        if String(char) != " "{
        print(char)
        if String(char) == "@"{
            converted+="√"
        }
        else if String(char) == "p"{
            converted+="π"
        }
        else{
            converted += String(char)
        }
        }
        
    }
    return converted
}
//print(expr.description)
//print(reversePolishNotation(expr))
// Simple demo
let expr = InfixExpressionBuilder()
    .addOperand(3)
    .addOperator(.add)
    .addOperand(4)
    .addOperator(.multiply)
    .addOperand(2)
    .addOperator(.divide)
    .addOpenBracket()
    .addOperand(1)
    .addOperator(.subtract)
    .addOperand(5)
    .addCloseBracket()
    .addOperator(.exponent)
    .addOperand(2)
    .addOperator(.exponent)
    .addOperand(3)
    
    .build()
