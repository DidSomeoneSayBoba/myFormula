//
//  FormulaTableViewCell.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 9/4/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import UIKit

class FormulaTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    var FormulaName:String!
    
    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var formulaitself: UILabel!
    @IBOutlet weak var actualformula: UILabel!
    var formula:String!
    var creationdate:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        actualformula.text = creationdate
     formulaitself.text = formula
         print(replaceAliases("3$(x)"))
        name.text = FormulaName
        
    }
    func inputswithcommas(_ a:String) -> String{
        var list = a.characters
        var final = ""
        var index = 0
        for char in list{
            if index == list.count-1{
                final += String(char)
            }
            else{
            final += String(char)+","
            }
            index += 1
        }
        return final
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
}
