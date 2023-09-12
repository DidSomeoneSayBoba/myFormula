 //
//  FormulasViewController.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 7/8/17.
//  Copyright © 2017 Aurelia Miyajima. All rights reserved.
//

import UIKit
import SQLite3
import QuartzCore
class FormulasViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    var gottem1:Formulae!
    var gottem = ""
   
    @IBOutlet weak var bottomFormula: NSLayoutConstraint!
    @IBOutlet weak var variablelist: UITextField!
    @IBOutlet weak var formula: UITextField!
    @IBOutlet weak var formulaName: UITextField!
    @IBOutlet weak var calcorformula: UISegmentedControl!
    @IBOutlet weak var formulalist: UITableView!
var Formulaarray:[Formulae] = []
    var formulaindex = 0
    var resultarray:[history] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        var userDefaults = UserDefaults.standard
      formulalist.layer.borderWidth=2.0
       //NotificationCenter.default.addObserver(self, selector: #selector(FormulasViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        if gottem != ""{
            gottem1 = StringtoFormula(Formula: gottem, formulaname: "scan ")}
       // NotificationCenter.default.addObserver(self, selector: #selector(FormulasViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        print("saved object: \(userDefaults.object(forKey: nameofformulaes))")
        if let data = userDefaults.object(forKey: nameofformulaes) {
            Formulaarray = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [Formulae]
            print("myPeopleList: \(Formulaarray[0].formula)")
        }else{
            print("There is an issue")
        }

        if let data = userDefaults.object(forKey: nameofhistories) {
          
           resultarray = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [history]
            print("myPeopleList: \(Formulaarray[0].formula)")
        }else{
            print("There is an issue")
        }
        // Do any additional setup after loading the view.
        self.formulalist.delegate = self
        self.formulalist.dataSource = self
        
        
        if gottem != ""{
        Formulaarray.append(gottem1)
        
        if (self.Formulaarray.isEmpty) != true {
            
            userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            userDefaults.synchronize()
            let data = NSKeyedArchiver.archivedData(withRootObject: self.Formulaarray)
            userDefaults.set(data, forKey: nameofformulaes)
            print("set data \(data) for key \(nameofformulaes)")
        }
        
        userDefaults.synchronize()
        self.formulalist.reloadData()
        }
    }
    func insertformula(_ targetformula:Formulae, _ table: String){
        let insertStatementString = "INSERT INTO history (name, formula, input,output) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            let name: NSString = targetformula.name as NSString
            let formula: NSString = targetformula.formula as NSString
            let inputs: NSString = targetformula.inputs.joined(separator:",") as NSString
            let outputs: NSString = targetformula.output as NSString
            //sqlite3_bind_int(insertStatement, 1, id)
            // 3
            sqlite3_bind_text(insertStatement,1,  name.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, formula.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, inputs.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, outputs.utf8String, -1, nil)
            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    @IBAction func addFormula(_ sender: Any) {
        var formulastring = converttomyformat(self.formula.text!)
        var userDefaults = UserDefaults.standard
        
        if formulastring == ""{
        }
        
        else{
            if formulastring.contains("=") == false{
                formulastring = formulastring + "=a"
        }
            let formulaname = self.formulaName.text!+"  "
            var formula1 = StringtoFormula(Formula: formulastring, formulaname: formulaname)
        print("formula1.inputs \(formula1.inputs)")
        Formulaarray.append(formula1)
        
        self.formula.text = ""
        self.formulaName.text = ""
        
       if (self.Formulaarray.isEmpty) != true {
         
            userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            userDefaults.synchronize()
            let data = NSKeyedArchiver.archivedData(withRootObject: self.Formulaarray)
            userDefaults.set(data, forKey: nameofformulaes)
        print("set data \(data) for key \(nameofformulaes)")
        }

                userDefaults.synchronize()
        self.formulalist.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func converttomyformat(_ equation:String)->String{
        let array = Array(equation)
        var final = ""
        var afterequation = false
        var firststring = ""
        var laststring = ""
        var charusedbefore = false
        var justchanged = false
        var myformat = false
        for char in array{
            if String(char) == "="{
                justchanged = true
                if firststring.count == 1{
                    myformat = true
                }
                afterequation = true
            }
            else {
                if afterequation == false{
                    
                    firststring += String(char)
                }
                else{
                    laststring += String(char)
                }
            }
        }
        if myformat == false{
            final = equation
        }
        else{
            final = laststring+"="+firststring
            
        }
        return matomta(final)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FormulaTableViewCell = self.formulalist.dequeueReusableCell(withIdentifier: "cell") as! FormulaTableViewCell
        var inputlist = ""
        var index = 0
        for thing in Formulaarray[indexPath.row].inputs {
            
            if index == Formulaarray[indexPath.row].inputs.count-1{
                inputlist += String(thing)
            }
            else{
                inputlist += String(thing)+","
            }
            index += 1
        }

        
        cell.creationdate = inputlist
        cell.formula = replaceAliases(convertEquation(Formulaarray[indexPath.row].toEquation1()))
        cell.FormulaName = Formulaarray[indexPath.row].name
        formulaindex += 1
        cell.setNeedsLayout()
        cell.awakeFromNib()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Formulaarray.count
        //edit to be companies
    }
    @IBAction func changed(_ sender: Any) {
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
            
            
            self?.performSegue(withIdentifier: "yes", sender: self)
        }

    }

    @IBAction func deleteDis(_ sender: UIButton) {
        var userDefaults = UserDefaults.standard
        var touchPoint = sender.convert(CGPoint.zero, to: self.formulalist)
        
        var clickedButtonIndexPath = formulalist.indexPathForRow(at: touchPoint)
        if (clickedButtonIndexPath?.row)! >= Formulaarray.count
        { Formulaarray.remove(at: (clickedButtonIndexPath?.row)!+1)}
        if (self.Formulaarray.isEmpty) != true {
            
            userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            userDefaults.synchronize()
            let data = NSKeyedArchiver.archivedData(withRootObject: self.Formulaarray)
            userDefaults.set(data, forKey: nameofformulaes)
            let data2 = NSKeyedArchiver.archivedData(withRootObject: self.resultarray)
            userDefaults.set(data2, forKey: nameofhistories)
            print("set data \(data) for key \(nameofformulaes) and also the other thing but who cares about it")}
        
        formulalist.reloadData()
    }
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.width+20)*(show ? -1 : 1)
        //5
        bottomFormula.constant -= changeInHeight
        
    }
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yes" {
            if let destination = segue.destination as? FormulasViewController {
                destination.resultarray = self.resultarray
                destination.Formulaarray = self.Formulaarray
                
            }
            
        }
    }
}
