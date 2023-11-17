//
//  GlobalTextFieldLeftRightIcon.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-14.
//

import Foundation
import UIKit

class GlobalTextFieldLeftRightIcon : UITextField {
    
    //***************************************
    // MARK: - Variables
    //***************************************
    var rightButton = UIButton(type: .custom)
    var hideRightView = true
    
    //***************************************
    // MARK: - System Functions
    //***************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.autocorrectionType = .no
        self.borderStyle = .none
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColorFromRGB(rgbValue: 0x029DE0).cgColor
        self.backgroundColor = .clear// GlobalTextFieldColorConstants.backgroundColor
    }
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //***************************************
    // MARK: - Other Functions
    //***************************************
    func setPlaceholderText(text : String = ""){
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: GlobalTextFieldColorConstants.placeholderColor,.font : GlobalTextFieldFontConstants.placeholderFont!])
        self.tintColor = GlobalTextFieldColorConstants.cursorColor
    }
    
    func setRightViewIcon(image: String,isPasswordTextField : Bool = false) {
        if isPasswordTextField{
            rightButton.setImage(UIImage(named: image), for: .normal)
            rightButton.frame = CGRect(x: 9, y: 11, width: 35, height: 25)
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 45))
        }else{
            rightButton.setBackgroundImage(UIImage(named: image), for: .normal)
            rightButton.frame = CGRect(x: 0, y: 2, width: 10 , height: 10)
            rightView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 15))
        }
        if isPasswordTextField{
            self.isSecureTextEntry = true
            if #available(iOS 12.0, *) {
                self.textContentType = .oneTimeCode
            } else {
                // Fallback on earlier versions
            }
        }
        if isPasswordTextField{
            rightButton.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
        }else{
            rightButton.addTarget(self, action: #selector(self.dropDownFunctionality), for: .touchUpInside)
        }
        rightView?.addSubview(rightButton)
        rightViewMode = .always
    }
    
    @objc func dropDownFunctionality() {
        print("DropDown Button tapped")
    }
    
    @objc func enablePasswordVisibilityToggle() {
        self.isSecureTextEntry.toggle()
        if self.isSecureTextEntry {
            self.rightButton.setImage(UIImage(named: GlobalIcons.passwordEyeVisible)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        }else{
            self.rightButton.setImage(UIImage(named: GlobalIcons.passwordEyeInVisible)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        }
    }
}
