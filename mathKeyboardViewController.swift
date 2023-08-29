//
//  KeyboardViewController.swift
//  mathKeyboard
//
//  Created by Aurelia Miyajima on 6/20/18.
//  Copyright © 2018 Aurelia Miyajima. All rights reserved.
//

import UIKit

class mathKeyboardViewController: UIInputViewController {
    var KeyboardView:UIView!
    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBOutlet weak var display: UILabel!
    override func updateViewConstraints() {
        super.updateViewConstraints()
                // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        loadInterface()
        clearDisplay()
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
    @IBAction func clearDisplay() {
        display.text = "0"
    }
    func loadInterface() {
        // load the nib file
        var mathNib = UINib(nibName: "mathKeyboard", bundle: nil)
        // instantiate the view
        KeyboardView = mathNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        // add the interface to the main view
        view.addSubview(KeyboardView)
        
        // copy the background color
        view.backgroundColor = KeyboardView.backgroundColor
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", for: .touchUpInside)
    }
    
}
