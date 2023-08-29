//
//  pseudoFormula.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 10/31/18.
//  Copyright © 2018 Aurelia Miyajima. All rights reserved.
//

import Foundation
class pseudoFormula: NSObject, NSCoding{
    var inputs:[String] = []
    var formula:String = ""
    var outputs:[String] = []
    var name:String = ""
    var output = ""
    var outputlist:[String] = []
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
    func toEquation()->String{
        var thing = Array(formula)
        var final = ""
        var index = 0
        for char in thing{
            if char=="い"{
                final+=inputs[index]
            }
            else{
                final+=inputs[index]
            }
        }
        return final
    }
}
