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
    //    func setFloatingActionButton(){
    //        self.layer.cornerRadius = self.frame.height / 2
    //        self.layer.masksToBounds = true
    //        self.tintColor = FloatingActionButtonColorConstants.tintColor
    //        self.titleLabel?.text = ""
    //        self.backgroundColor = UIColor.white
    //        self.setImage(UIImage(named: DashboardImageConstants.imgiconEventAdd), for: .normal)
    //    }
    //    func setFloatingActionButtonAdd(){
    //        self.layer.cornerRadius = self.frame.height / 2
    //        self.layer.masksToBounds = true
    //        self.tintColor = UIColor.white
    //        self.setImage(UIImage(named: DashboardImageConstants.imgAdd), for: .normal)
    //        self.titleLabel?.text = ""
    //        self.backgroundColor = FloatingActionButtonColorConstants.tintColor
    //    }
    
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

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    // to modify UIButton to be visible like Radio button
    func radioButton(){
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitle("", for: .normal)
        self.setImage(UIImage(named: "rdbtn_unchecked")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.setImage(UIImage(named: "rdbtn_checked")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        self.setImage(UIImage(named: "rdbtn_checked")?.withRenderingMode(.alwaysOriginal), for: .selected)
    }
}

//***************************************
// MARK: - UIButton Color Constants
//***************************************
struct GlobalButtonColorConstants{
    static let enableTextColor = UIColor.black
    static let disableTextColor = UIColor.lightGray
    static let enableBackgroundColor = UIColor.white
    static let disableBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let clearBackgroundColor = UIColor.clear
    static let clearBackgroundTextColor = UIColor(red: 24.0/255.0, green: 185.0/255.0, blue: 154.0/255.0, alpha: 1.0)
}

//***************************************
// MARK: - UIButton Font Family Constants
//***************************************
struct GlobalButtonFontFamily {
    static let clearBtnTextFont = UIFont(name: OpenSansFontsFamily.fontBold, size: 14.0)
    static let enableNormalBtnTextFont = UIFont(name: OpenSansFontsFamily.fontBold, size: 14.0)
    static let disableNormalBtnTextFont = UIFont(name: OpenSansFontsFamily.fontRegular, size: 14.0)
}

//***************************************
// MARK: - DropDown Color Constants
//***************************************
struct DropDownConstants{
    static let backgroundColor  = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
    static let textColor = UIColor.white
    static let selectedBackgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    static let selectedTextColor = UIColor.white
    static let separatorColor = UIColor.white
}

//***************************************
// MARK: - TextField Color Constants
//***************************************
struct GlobalTextFieldColorConstants {
    static let textColor = UIColor.white
    static let placeholderColor = UIColorFromRGB(rgbValue: 0x7e7e7e).withAlphaComponent(0.5)
    static let backgroundColor = UIColorFromRGB(rgbValue: 0x30f6db).withAlphaComponent(0.05)
    static let borderColor = UIColor.white.cgColor
    static let cursorColor = UIColor.black
}

//***************************************
// MARK: - TextField Font Constants
//***************************************
struct GlobalTextFieldFontConstants{
    static let font = UIFont(name: OpenSansFontsFamily.fontDemiBold, size: 15.0)
    static let placeholderFont = UIFont(name: OpenSansFontsFamily.fontRegular, size: 15.0)
}

//***************************************
// MARK: - TextView Color Constants
//***************************************
struct GlobalTextViewColorConstants {
    static let textColor = UIColor.white
    static let backgroundColor = UIColor.clear
    static let borderColor = UIColor.white.cgColor
}

//***************************************
// MARK: - TextView Font Constants
//***************************************
struct GlobalTextViewFontConstants{
    static let font = UIFont(name: OpenSansFontsFamily.fontDemiBold, size: 15.0)
}

//***************************************
// MARK: - Heading Label Font Family Constants
//***************************************
struct GlobalHeadingLabelFontFamily {
    static let headingLabelFont  = UIFont(name: OpenSansFontsFamily.fontBold, size: 20)
    static let headingMediumLabelFont  = UIFont(name: OpenSansFontsFamily.fontBold, size: 18)
}

//***************************************
// MARK: - Heading Label Color Constants
//***************************************
struct GlobalHeadingLabelColorConstants{
    static let headingTextColor = UIColor.darkGray
    static let headingBackgroundColor = UIColor.clear
}

//***************************************
// MARK: - Toast Label Color Constants
//***************************************
struct GlobalToastLabelColorConstant{
    static let toastBackgroundColor = UIColorFromRGB(rgbValue: 0x7e7e7e) //UIColor(red: 254.0/255.0, green: 84.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    static let toastTintColor = UIColor.white
}

//***************************************
// MARK: - Toast Label Font Family Constants
//***************************************
struct GlobalToastLabelFontFamily {
    static let toastLabelFont  = UIFont(name: OpenSansFontsFamily.fontRegular, size: 14)!
}

//***************************************
// MARK: - Sub Heading Label Font Family Constants
//***************************************
struct GlobalSubHeadingLabelFontFamily {
    static let subHeadingLabelFont  = UIFont(name: OpenSansFontsFamily.fontRegular, size: 16)
}

//***************************************
// MARK: - Sub Heading Label Color Constants
//***************************************
struct GlobalSubHeadingLabelColorConstants{
    static let subHeadingTextColor = UIColor.darkGray
    static let subHeadingBackgroundColor = UIColor.clear
}

//***************************************
// MARK: - Label with rounded corners Constants
//***************************************
struct GlobalRoundedCornerLabel{
    static let backgroundColor = UIColor(red: 25.0/255.0, green: 28.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    static let font = UIFont.init(name: OpenSansFontsFamily.fontBold, size: 14.0)
}

//***************************************
// MARK: - RGB Color Code Function
//***************************************
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
