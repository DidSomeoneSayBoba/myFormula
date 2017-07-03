//
//  Formula array saver thing idk.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 7/2/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import Foundation
//Formula Struct
struct Formula{
    var inputs:[String]
    var formula:String
}
//Array of Formulas

//String into usable formula
func StringtoFormula(Formula:String){
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
    
    var finalString = Array(charsinformula.characters)
    var finalString1 = Array(charsinformula.characters)
    var indexforabovestring = 0
    for uni in charsinformula.unicodeScalars {
        if letters.contains(uni) {
            letterCount += 1
            var strofcharatindex = String(finalString[indexforabovestring])
            inputs1.append(strofcharatindex)
            formulastring+="あ\(indexforabovestring)"
        } else if digits.contains(uni) {
            digitCount += 1
            
        }else if greekletters.contains(uni) {
            greekCount += 1
        }
        else if sqrt.contains(uni){
            
        }
     indexforabovestring+=1
    }
    
}
