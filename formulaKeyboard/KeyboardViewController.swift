//
//  KeyboardViewController.swift
//  formulaKeyboard
//
//  Created by Michael K Miyajima on 6/26/18.
//  Copyright © 2018 Michael Miyajima. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    var keyboardView:UIView!
    @IBOutlet var nextKeyboardButton: UIButton!
    var underlyingLabel:String = ""
    @IBOutlet weak var display: UILabel!
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.addSubview(keyboardView)
       // nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", for: .touchUpInside)
        //clearDisplay()
        // Perform custom UI setup here
        print("hi")
       // var proxy = textDocumentProxy as UITextDocumentProxy
        //display.text = proxy.selectedText
        /*
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true*/
         self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    @IBAction func nextKeyboard(sender: AnyObject) {
        // #selector(handleInputModeList(from:with:))
        var proxy = textDocumentProxy as UITextDocumentProxy
        display.text = ""
        proxy.insertText(underlyingLabel)
        underlyingLabel = ""
    }
    @IBAction func addfuncSymbol(sender: UIButton) {
        var proxy = textDocumentProxy as UITextDocumentProxy
        let normalOps = ["ºsin(x)","ºcos(x)","ºtan(x)","sin(x)","tan(x)","cos(x)","log(x)"]
        if normalOps.contains(sender.currentTitle!){
            if sender.currentTitle == "sin(x)"{
                underlyingLabel += "1$"
                
                display.text = display.text! + "sin"
            }
            else if sender.currentTitle == "cos(x)"{
                underlyingLabel += "2$"
                display.text = display.text! + "cos"
            }
            else if sender.currentTitle == "tan(x)"{
                underlyingLabel = underlyingLabel + "3$"
                display.text = display.text! + "tan"
            }
            else if sender.currentTitle == "ºsin(x)"{
                underlyingLabel += "4$"
                display.text = display.text! + "ºsin"
            }
            else if sender.currentTitle == "ºcos(x)"{
                underlyingLabel += "5$"
                display.text = display.text! + "ºcos"
            }
            else if sender.currentTitle == "ºtan(x)"{
                underlyingLabel += "6$"
                display.text = display.text! + "ºtan"
            }
            else if sender.currentTitle == "log(x)"{
                underlyingLabel += "10?"
                display.text = display.text! + "log"
            }
            else if sender.currentTitle == "(base)log(x)"{
                underlyingLabel += "?"
                display.text = display.text! + "log"
            }
            
           
        }
        else{
            underlyingLabel += sender.currentTitle!
            display.text = display.text!+""+sender.currentTitle!
        }
      //  proxy.insertText(underlyingLabel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
 
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    @IBAction func insertText(_ sender: Any) {
        var proxy = textDocumentProxy as UITextDocumentProxy
        
        if let input = underlyingLabel as String? {
            proxy.insertText(underlyingLabel)
        }
        display.text = ""
        
        underlyingLabel = ""
       // dismissKeyboard()
    }
    @IBAction func endEdit(_ sender: Any) {
        var proxy = textDocumentProxy as UITextDocumentProxy
        display.text = ""
        proxy.insertText(underlyingLabel)
        underlyingLabel = ""
        dismissKeyboard()
    }
    @IBAction func clearDisplay() {
        display.text = ""
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

            
            var nib = UINib(nibName: "mathKeyboard", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        keyboardView = objects[0] as! UIView
     //   keyboardView.frame.size = view.frame.size
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
