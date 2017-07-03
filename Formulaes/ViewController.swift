//
//  ViewController.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 6/17/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var egformula = "x*3=t"
var quadformula = "√x=x"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StringtoFormula(Formula:egformula)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

