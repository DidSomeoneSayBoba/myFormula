//
//  thing.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 8/24/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import Foundation

class history: NSObject, NSCoding{
    var Formulaname:String
    var equation:String
    var date:String
    init(Formulaname:String, equation:String, date:String){
        self.Formulaname = Formulaname
        self.equation = equation
        self.date=date
    }
    required init?(coder aDecoder: NSCoder) {
        
        self.Formulaname = (aDecoder.decodeObject(forKey: "Formulaname") as? String)!;
        self.equation = (aDecoder.decodeObject(forKey: "equation") as? String)!;
        self.date = (aDecoder.decodeObject(forKey: "date") as? String)!;
    }
    
    func encode(with: NSCoder) {
        with.encode(self.Formulaname, forKey: "Formulaname");
        with.encode(self.equation, forKey: "equation");
        with.encode(self.date, forKey: "date");
    }

}
