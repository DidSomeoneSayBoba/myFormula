//
//  ViewController.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 6/17/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var Formulaarray:[Formulae] = []
var egformula = "x*3=t"
var quadformula = "(-b+-√b^2-4ac)/2a=t"
    var testmultipleinputs = "t+a+b=c"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Formulaarray.append(StringtoFormula(Formula:egformula))
        Formulaarray.append(StringtoFormula(Formula:quadformula))
        Formulaarray.append(StringtoFormula(Formula:testmultipleinputs))
        var testformula = StringtoFormula(Formula:testmultipleinputs)
        print(Formulaarray)
        var testintarray = [4,1,2]
        testformula.run(testintarray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

