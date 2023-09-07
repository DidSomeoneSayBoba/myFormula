//
//  constanttables.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 10/12/17.
//  Copyright © 2017 Aurelia Miyajima. All rights reserved.
//

import Foundation
//final names were commented
var reset = false
let nameofformulaes = "pleaewkotherwieyouregonnaembaras"
let nameofhistories = "andyillbedestoyedgg"
var dolfortrig = true
let dbpath = "./myformula.db"

let createTableString = """
CREATE TABLE "myformula" (
    "id"    INTEGER NOT NULL,
    "name"    TEXT NOT NULL,
    "formula"    TEXT,
    "input"    TEXT,
    "output"    TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
)

CREATE TABLE "history" (
    "id"    INTEGER NOT NULL,
    "myformula_id"    INTEGER NOT NULL,
    "equation"    TEXT,
    "date"    TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
)
"""
func matomta(_ equation:String)->String{//what does this even mean
    var final = ""
    var lettersinarow = false
    var afterdigit = false
    let letters = ["A","B","C","D","E","F","G","H","I","J","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","f","g","h","i","j","k","l","m","n","o","q","r","s","t","u","v","w","x","y","z"]
    let digits = ["0","1","2","3","4","5","6","7","8","9","p","π","φ","K","e"]
    let array = Array(equation)
    for char in array{
        if letters.contains(String(char)){
            if lettersinarow == true{
                final += "*"
                final += String(char)
            }
            else if afterdigit == true{
                final += "*"
                final += String(char)
            }
            else{
                final += String(char)
                lettersinarow = true
            }
            
        }
        else if digits.contains(String(char)){
            
            
                final += String(char)
                afterdigit = true
            
        }
        else{
            afterdigit = false
            
            lettersinarow = false
                final += String(char)
                
            
        }
        
    }
    return final
}
