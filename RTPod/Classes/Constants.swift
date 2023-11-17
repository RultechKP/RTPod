//
//  Constants.swift
//  RTPod
//
//  Created by Krutika on 2023-10-31.
//

import Foundation


//***************************************
// MARK: - Global Texts Constants
//***************************************
struct GlobalTexts {
    static let serverSideFailureMessage = "Something went wrong! Please try again later."
    static let dataNotFound = "Data not found"
    static let noInternet = "No Internet"
    static let goToSettings = Locale.localize("goToSettings")
    static let cameraAccessDenied = Locale.localize("cameraAccessDenied")
    static let error = Locale.localize("error")
    static let chooseFrom = Locale.localize("chooseFrom")
    static let camera = Locale.localize("camera")
    static let cameraNotAvailable = Locale.localize("cameraNotAvailable")
    static let photos = Locale.localize("photos")
    static let others = Locale.localize("others")
}


//***************************************
// MARK: - Global Font Family Names Constants
//***************************************
struct OpenSansFontsFamily {
    static let fontLight = "OpenSans-Light"
    static let fontLightItalic = "OpenSans-LightItalic"
    
    static let fontRegular = "OpenSans-Regular"
    static let fontRegularItalic = "OpenSans-Italic"
    
    static let fontMedium = "OpenSans-Medium"
    static let fontMediumItalic = "OpenSans-MediumItalic"
    
    static let fontDemiBold = "OpenSans-SemiBold"
    static let fontDemiBoldItalic = "OpenSans-SemiBoldItalic"
    
    static let fontBold = "OpenSans-Bold"
    static let fontBoldItalic = "OpenSans-BoldItalic"
    
    static let fontExtraBold = "OpenSans-ExtraBold"
    static let fontExtraBoldItalic = "OpenSans-ExtraBoldItalic"
}

//***************************************
// MARK: - Global Colors Constants
//***************************************
struct CommonColors{
    static let gradientLightColor = UIColorFromRGB(rgbValue: 0xadbcdb)
    static let gradientDarkColor = UIColorFromRGB(rgbValue: 0x3754a2)
    static let segmentBackgroundColor = UIColorFromRGB(rgbValue: 0x3754a2)
    static let buttonBackgroundColor = UIColorFromRGB(rgbValue: 0x3754a2)
    static let titleTextColor = UIColorFromRGB(rgbValue: 0x3754a2)
    static let subjectTextColor = UIColorFromRGB(rgbValue: 0x009de0)
}

//***************************************
// MARK: - Global Images Names Constants
//***************************************
struct GlobalIcons {
    static let passwordEyeVisible = "passwordEyeInvisible"
    static let passwordEyeInVisible = "passwordEyeVisible"
    static let back = "arrowBack"
    static let successToast = "toastSuccess"
    static let failureToast = "toastFailure"
    static let popUpBackground = "popUpBackground"
    static let close = "close"
    static let menu = "menu"
    static let placeholder = "placeholder"
    static var imgAdd = "add"
    static var emptyTextFieldIcon = "emptyTextFieldIcon"
    static var filledTextFieldIcon = "filledTextFieldIcon"
}

//***************************************
// MARK: - User's Device keyboard height
//***************************************
struct Keyboard{
    static var height = 0.0
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
// MARK: - Floating Action Button Constants
//***************************************
struct FloatingActionButtonColorConstants{
    static let tintColor = UIColor.white
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
