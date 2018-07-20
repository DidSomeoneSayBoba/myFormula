//
//  ViewController.swift
//  Formulaes
//
//  Created by Michael K Miyajima on 6/17/17.
//  Copyright © 2017 Michael Miyajima. All rights reserved.
//

import UIKit
import QuartzCore
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var heightThing: NSLayoutConstraint!
    @IBOutlet weak var namePicker: UIPickerView!
    var Formulaarray:[Formulae] = [StringtoFormula(Formula:"a+b=c",formulaname:"example")]
    var dateindex = 0
    var formulanames:[String] = []
    var resultarray:[history] = []
    
    @IBOutlet weak var calchistorytableview: UITableView!
    @IBOutlet weak var calculatehere: UITextField!
    @IBOutlet weak var calcorformula: UISegmentedControl!

    @IBOutlet weak var calcbutton: UIButton!
    
    @IBOutlet weak var egformula: UILabel!
    var egformula1 = "x*3=t"
var quadformula = "(-b+-√b^2-4ac)/2a=t"
    var parntest = "9+(x+a+s)*b"
    var parntest1 = "(x+a)-b"
    var testmultipleinputs = "t+a+b=c"
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.height+20)*(show ? -1 : 1)
        //5
        heightThing.constant = heightThing.constant - changeInHeight
        
    }
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
 calchistorytableview.layer.borderWidth=2.0
        if reset == true{
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }}
        egformula.text = convertEquation(Formulaarray[0].toEquation1())
        var userDefaults = UserDefaults.standard
      
        if let data = userDefaults.object(forKey: nameofformulaes) {
            Formulaarray = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [Formulae]
            print("FOrmulas: \(Formulaarray)")
        }else{
            print("There is an issue")
        }
        print("saved object: \(userDefaults.object(forKey: nameofhistories))")
        if let data = userDefaults.object(forKey: nameofhistories) {
            resultarray = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [history]
            print("history: \(resultarray[0].date)")
        }else{
            print("There is an issue")
        }
        
        print("formulaarray is \(Formulaarray)")
        print("historyarray is \(resultarray)")
        // Do any additional setup after loading the view, typically from a nib.
     /*
        var testformula = StringtoFormula(Formula:testmultipleinputs,formulaname:"woah")
        print(Formulaarray)
        var testintarray = [40,1,2,3]
        var thing = testformula.run2(testintarray)
        var test = StringtoFormula(Formula:parntest,formulaname:"memes")
        var test2 = StringtoFormula(Formula:parntest1,formulaname:"LOL")
        
        print(test.run2(testintarray))
       postfixcalc(test2.run2(testintarray))
        var thin = postfixEvaluate(equation1: test2.run2(testintarray))
        
       */
        OperationQueue.main.addOperation({
            
            self.calchistorytableview.delegate = self
            self.calchistorytableview.dataSource = self
            
            
            self.calchistorytableview.reloadData()
            
            
        })
        
        let data = NSKeyedArchiver.archivedData(withRootObject: self.Formulaarray)
        userDefaults.set(data, forKey: nameofformulaes)
        print("set data for key \(nameofformulaes)")
        namePicker.delegate = self
        namePicker.dataSource = self

        userDefaults.synchronize()
        
        self.formulanames = []
        for thing in Formulaarray {
            formulanames.append(replaceAliases(thing.name))
        }
    }
    func stringNormally(_ signString: String){
        let string = Array(signString)
        let signs = ["?","$","@"]
    }
    @IBAction func calculate(_ sender: Any) {
   /*var userDefaults = UserDefaults.standard
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        self.Formulaarray = []
        self.resultarray = []
        userDefaults.synchronize()*/
        var thing1 = false
        for char in (calculatehere.text?.characters)!{
            if String(char) == "="{
                thing1 = true
            }
        }

        var selected = namePicker.selectedRow(inComponent: 0)
        var usingformula = Formulaarray[selected]
       
    if calculatehere.text == ""{
         print(usingformula.inputs)
        calcbutton.isEnabled = false
        calculatehere.text = "hey"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            
            // Put your code which should be executed with a delay here
            self.calculatehere.text = "did"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.calculatehere.text = "you"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.calculatehere.text = "just"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.calculatehere.text = "PRESS"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            self.calculatehere.text = "caLCUlate"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                self.calculatehere.text = "withOUt"
                                self.calculatehere.textColor=UIColor.brown
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    self.calculatehere.text = "InPuTs?"
                                    self.calculatehere.textColor=UIColor.blue
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                        self.calculatehere.text = "SERIOUSLY?!?!?!?!?!"
                                     self.calculatehere.textColor=UIColor.cyan
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                            
                              
                                            
                                            self.calculatehere.textColor=UIColor.blue
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                                
                                                self.calculatehere.textColor=UIColor.cyan
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                             self.calculatehere.textColor = UIColor.blue
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                            self.calculatehere.text = ""
                                                        self.calculatehere.textColor=UIColor.black})})})})
})
})
})
})

                        
                    })
                })
            })
            
        })
        
        calcbutton.isEnabled = true
        
    }
            else if thing1 == true{
        calculatehere.text = "no support for direct equations yet"
    }
    else{
        calcbutton.isEnabled = false
        
        let thing = stringwithoutcommas(calculatehere.text!)
        
        
        print(thing)
        let formula = Formulaarray[namePicker.selectedRow(inComponent: 0)]
        let postfixformula = formula.run2(thing)
        print("postfixformula is \(postfixformula)")
        print("postfixEvaluate(equation1: postfixformula) is \(postfixEvaluate(equation1: postfixformula))")
        let date1 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.string(from:date1)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date1)
        let minutes = calendar.component(.minute, from: date1)
        let whole = "\(date),\(hour):\(minutes)"
        let result = "\(formula.toEquation(thing))"+String(postfixEvaluate(equation1: postfixformula))
        let formulaname = Formulaarray[namePicker.selectedRow(inComponent:0)].name
        let historything = history(Formulaname:formulaname, equation:replaceAliases(convertEquation(result)), date:whole)
        resultarray.append(historything)
        //works?
        calchistorytableview.reloadData()
        calcbutton.isEnabled = true
        calculatehere.text = ""
        }
    }
    func stringwithoutcommas(_ a:String)->[Double]{
        
        let list1 = Array(replaceSymbs(a))
        var list:[String] = []
        for thing in list1{
            if String(thing) != ","{
                
                list.append(String(thing))}
            else{
                list.append(" ")
            }
        }
        
        var stirng:[Double] = []
        var index = 0
        var tempstring = ""
        for char in list {
            if char != "+" || char != "-" || char != "=" || char != "/" || char != "*" || char != "^"  {
            if char == " "{
                print("found space at index \(index)")
                if(tempstring != ""){
                    stirng.append(Double(tempstring)!)
                    tempstring = ""
                }
        }
            else{
                tempstring += char
                
                if index == list.count-1{
                    stirng.append(Double(tempstring)!)
                }
            
        }
        index += 1
            }
        }
        return stirng
    }
    @IBAction func changevalueofsegment(_ sender: UISegmentedControl) {
        OperationQueue.main.addOperation {
            
            [weak self] in
            var userDefaults = UserDefaults.standard
            if (self?.resultarray.isEmpty)! != true {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: self?.Formulaarray)
                userDefaults.set(data, forKey: nameofformulaes)}
            if (self?.resultarray.isEmpty) != true{
            let data1 = NSKeyedArchiver.archivedData(withRootObject: self?.resultarray)
            userDefaults.set(data1, forKey: nameofhistories)
            }
       userDefaults.synchronize()


            self?.performSegue(withIdentifier: "no", sender: self)
                    }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CalcTableViewCell = self.calchistorytableview.dequeueReusableCell(withIdentifier: "cell") as! CalcTableViewCell
        cell.date = resultarray[indexPath.row].date
        cell.equation = resultarray[indexPath.row].equation
        cell.formula = resultarray[indexPath.row].Formulaname
        dateindex += 1
        cell.setNeedsLayout()
        cell.awakeFromNib()
        return cell
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultarray.count
        //edit to be companies
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var converted = convertEquation(Formulaarray[row].toEquation1())
        print("converted = \(converted)")
        egformula.text = replaceAliases(converted)
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  Formulaarray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Formulaarray[row].name
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
    func replaceSymbs(_ symbstring:String)->String{
        var final = ""
        let array = Array(symbstring)
        for char in array{
            if String(char) == "π"||String(char) == "p"{
                final += String(Double.pi)
            }
            else if String(char) == "e"{
                final += "2.718281828459045235360287471352662497757247093699959549669676277240766303535475945713821785251664274"
            }
            else if String(char) == "K"{
                var boltzmann = 1.38
                boltzmann = boltzmann*Double((10^(-23)))
                final += String(boltzmann)
            }
            else if String(char) == "φ"{
                var boltzmann = sin(54.00)*(180/Double.pi)
                boltzmann = boltzmann*2
                final += String(boltzmann)
            }
            else{
                final += String(char)
            }
        }
        return final
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "no" {
            if let destination = segue.destination as? FormulasViewController {
                destination.resultarray = self.resultarray
                destination.Formulaarray = self.Formulaarray
                
            }
            
        }
    }
    }
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  
    

}
