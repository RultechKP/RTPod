//
//  GlobalButtonControl.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-02.
//

import Foundation
import UIKit

class GlobalButtonControl: UIButton {
    
    //***************************************
    // MARK: - Variables
    //***************************************
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                super.isHighlighted = false
            }
        }
    }
    
    //***************************************
    // MARK: - System Functions
    //***************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.titleLabel?.font = GlobalButtonFontFamily.enableNormalBtnTextFont
        self.setTitleColor(GlobalButtonColorConstants.enableTextColor, for: .normal)
        self.backgroundColor = GlobalButtonColorConstants.enableBackgroundColor
    }
    
    //***************************************
    // MARK: - Other Functions
    //***************************************
    func setTitleImageButton(title : String,img : String,textColor : UIColor = .white,font : UIFont){
        self.setBackgroundImage(UIImage(named: img)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.contentEdgeInsets = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
    }
    
    func setSmallRoundedCornerButton(title : String,backgroundColor : UIColor = GlobalButtonColorConstants.enableBackgroundColor,textColor : UIColor = UIColor.white,font : UIFont,img : String = ""){
        if img.count > 0{
            self.setBackgroundImage(UIImage(named: img)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        }else{
            self.setBackgroundImage(UIImage(named: ""), for: .normal)
            self.backgroundColor = backgroundColor
        }
        self.layer.cornerRadius = 5
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
    }
    
    func setUnderlinedButton(title : String,backgroundColor : UIColor = UIColor.clear,textColor : UIColor = UIColorFromRGB(rgbValue: 0x0f68da),font : UIFont = GlobalButtonFontFamily.enableNormalBtnTextFont!,setUnderline : Bool = true){
        self.layer.cornerRadius = 5
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        if setUnderline{
            self.underline()
        }
    }
    
    //set rounded Corner button with only texts
    func setRoundedCornerButton(title : String,backgroundColor : UIColor = GlobalButtonColorConstants.enableBackgroundColor,font : UIFont,textColor : UIColor = UIColor.white){
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
    }
    
    //set button design as it is enable
    func enabledRoundedButton(title : String,backgroundColor : UIColor = GlobalButtonColorConstants.enableBackgroundColor,titleColor : UIColor = GlobalButtonColorConstants.enableTextColor){
        self.isUserInteractionEnabled = true
        self.titleLabel?.font = GlobalButtonFontFamily.enableNormalBtnTextFont
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    //set button design as it is disable
    func disabledRoundedButton(title : String){
        self.isUserInteractionEnabled = false
        self.titleLabel?.font = GlobalButtonFontFamily.disableNormalBtnTextFont
        self.setTitleColor(GlobalButtonColorConstants.disableTextColor, for: .normal)
        self.backgroundColor = GlobalButtonColorConstants.disableBackgroundColor
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    //set button design as it is clear background
    func clearBackgroundButton(title : String,titleColor : UIColor = GlobalButtonColorConstants.clearBackgroundTextColor,font : UIFont = GlobalButtonFontFamily.clearBtnTextFont!,backgroundColor : UIColor = GlobalButtonColorConstants.clearBackgroundColor){
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    //set floating action button
    func setFloatingActionButton(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.tintColor = FloatingActionButtonColorConstants.tintColor
        self.titleLabel?.text = ""
        self.backgroundColor = UIColor.white
        self.setImage(UIImage(named: GlobalIcons.imgAdd), for: .normal)
    }
    
    func setFloatingActionButtonAdd(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.tintColor = UIColor.white
        self.setImage(UIImage(named: GlobalIcons.imgAdd), for: .normal)
        self.titleLabel?.text = ""
        self.backgroundColor = FloatingActionButtonColorConstants.tintColor
    }
    
    //set rounded Image Button
    func setRoundedImageButton(img : String,text : String = "",textColor : UIColor = GlobalButtonColorConstants.enableTextColor,font : UIFont = GlobalButtonFontFamily.clearBtnTextFont!){
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.titleLabel?.font = font
        self.setBackgroundImage(UIImage(named: img)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.setTitle(text, for: .normal)
    }
}

