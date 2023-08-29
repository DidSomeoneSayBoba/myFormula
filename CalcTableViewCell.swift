//
//  CalcTableViewCell.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 8/24/17.
//  Copyright © 2017 Aurelia Miyajima. All rights reserved.
//

import UIKit

class CalcTableViewCell: UITableViewCell {
    var index:Int!
    var date:String!
    var equation:String!
    var formula:String!
    @IBOutlet weak var formuladate: UILabel!
    @IBOutlet weak var formulaused: UILabel!
    @IBOutlet weak var formulaname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        formuladate.text = date
        
            formulaused.text = equation
            
        
        formulaname.text = formula
        
    }
    func replaceAliases(_ equation:String)->String{
        var tempcharacter = ""
        var final = ""
        
        let chars = Array(equation)
        let lastindex = chars.count
        var index = 0
        var chars2 = Array(equation)
        var strns:[String] = []
        for char in chars2{
            strns.append(String(char))
        }
        for char in chars{
            if String(char) == "$"{
                if tempcharacter == "1"{
                    strns[index-1] = ""
                    strns[index] = "sin"
                    final += "sin"
                }
                if tempcharacter == "2"{
                    strns[index-1] = ""
                    strns[index] = "cos"
                    final += "cos"
                }
                if tempcharacter == "3"{
                    strns[index-1] = ""
                    strns[index] = "tan"
                    final += "tan"
                }
                if tempcharacter == "4"{
                    strns[index-1] = ""
                    strns[index] = "ºsin"
                    final += "ºsin"
                }
                if tempcharacter == "5"{
                    strns[index-1] = ""
                    strns[index] = "ºcos"
                    final += "ºcos"
                }
                if tempcharacter == "6"{
                    strns[index-1] = ""
                    strns[index] = "ºtan"
                    final += "ºtan"
                }
            }
            else if String(char) == "?"{
                if tempcharacter != "0"{
                    
                    strns[index] = "log"
                    final += tempcharacter
                }
                else
                {
                    strns[index-1] = ""
                    strns[index] = "log"
                }
                final += "log"
            }
            else if String(char) == "@"{
                final += tempcharacter
                final += "√"
                
                strns[index] = "√"
            }
            else if String(char) == "+" || String(char) == "-" || String(char) == "/" || String(char) == "*" || String(char) == "^" || String(char) == "%"{
                
                final += tempcharacter
                final += String(char)
            }
            if index == lastindex-1 {
                if tempcharacter != ""{
                    final += tempcharacter
                    
                }
                final += String(char)
            }
            tempcharacter = String(char)
            index += 1
        }
        var thin = ""
        
        for thing in strns{
            thin += thing
        }
        print(final)
        return thin
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
