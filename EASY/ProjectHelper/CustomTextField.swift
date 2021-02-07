//
//  CustomTextField.swift
//  EASY
//
//  Created by Rohit Saini on 09/02/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//


import UIKit

//@IBDesignable
class TextField: UITextField {
    
   
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
   
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet {
            if(leftPadding != 0){
                let leftView = UIView()
                leftView.frame = CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height)
                
                self.leftView = leftView
                self.leftViewMode = .always
            }
        }
    }
   
    
    @IBInspectable var isPasteDisable : Bool = false {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.width))
        //        self.leftViewMode = UITextFieldViewMode.always
        //        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        //        self.rightViewMode = UITextFieldViewMode.always
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return isPasteDisable
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
