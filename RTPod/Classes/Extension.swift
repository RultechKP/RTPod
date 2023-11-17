//
//  URL.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-04-12.
//

import Foundation


//***************************************
// MARK: - UItextField 
//***************************************
extension UITextField {
    
    func setCountryCodeLeftView(image: String = "") {
        let paddingView = UIView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let iconView = UIImageView(frame: CGRect(x: 5, y: 5, width: 10, height: 10))
        iconView.image = UIImage(named: image)
        let iconContainerView: UIView = UIView()
        iconContainerView.frame = CGRect(x: 5, y: 0, width: 10, height: 10)
        paddingView.addSubview(iconView)
        leftView = paddingView
        leftViewMode = .always
        rightViewMode = .never
    }
    
    func setLeftView(image: String = "") {
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.size.height))
        let iconView = UIImageView(frame: CGRect(x: 0, y: -4, width: 50, height: 50))
        iconView.image = UIImage(named: image)
        let iconContainerView: UIView = UIView()
        if image == ""{
            paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
            iconContainerView.frame = CGRect(x: 0, y: 0, width: 0, height: 45)
        }else{
            iconContainerView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        }
        paddingView.addSubview(iconView)
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

//***************************************
// MARK: - UIApplication
//***************************************
extension UIApplication {
    var statusBarView: UIView?{
        return value(forKey: "statusBar") as? UIView
    }
}

//***************************************
// MARK: - Int
//***************************************
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

//***************************************
// MARK: - String
//***************************************
extension String{
    var isStringText: Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = self.rangeOfCharacter(from: decimalCharacters)
        if decimalRange != nil {
            return false
        }else {
            return true
        }
    }
    
    var isAlphanumericDashUnderscore: Bool {
        get {
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9_]*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    }
    
    /**
     //     Converts a string of format HH:mm:ss into seconds
     //     ### Expected string format ###
     //     ````
     //        HH:mm:ss or mm:ss
     //     ````
     //     ### Usage ###
     //     ````
     //        let string = "1:10:02"
     //        let seconds = string.inSeconds  // Output: 4202
     //     ````
     //     - Returns: Seconds in Int or if conversion is impossible, 0
     */
    var inSeconds : Int {
        var total = 0
        let secondRatio = [1, 60, 3600]    // ss:mm:HH
        for (i, item) in self.components(separatedBy: ":").reversed().enumerated() {
            if i >= secondRatio.count { break }
            total = total + (Int(item) ?? 0) * secondRatio[i]
        }
        return total
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
    
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[1]) ?? 0
        let seconds = Int(components[2]) ?? 0
        return (hours * 3600) + (minutes * 60) + seconds
    }
    
    //***************************************
    // MARK: - Validate Password
    //***************************************
    func isValidPassword() -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
    
    func getFormattedDisplayText() -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString.init(string: self)
        let startTag = "<blue>"
        let endTag = "</blue>"
        
        while mutableAttributedString.string.contains(startTag) && mutableAttributedString.string.contains(endTag){
            let string_to_color = mutableAttributedString.string.slice(from: startTag, to: endTag)
            let range = mutableAttributedString.mutableString.range(of: string_to_color ?? "")
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
            mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: OpenSansFontsFamily.fontDemiBold, size: 16)! , range: range)
            let deleteRange1 = (mutableAttributedString.string as NSString).range(of: startTag)
            mutableAttributedString.deleteCharacters(in: deleteRange1)
            let deleteRange2 = (mutableAttributedString.string as NSString).range(of: endTag)
            mutableAttributedString.deleteCharacters(in: deleteRange2)
        }
        return mutableAttributedString
    }
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}


//***************************************
// MARK: - Float for second to time conversion,slider value to time conversion
//***************************************
extension CGFloat {
    
    func secondsToTime() -> String {
        
        let (h,m,s) = (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
        
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        
        return "\(h_string)" == "00" ?  (" " + "\(m_string):\(s_string)" + " ") :  (" " + "\(h_string):\(m_string):\(s_string)" + " ")
    }
    
    func sliderValueToTime() -> String{
        let (h,m,s) = (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
        
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        
        return "\(h_string):\(m_string):\(s_string)"
    }
}

//***************************************
// MARK: - URL
//***************************************
extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

//***************************************
// MARK: - UIView - set rounded corner
//***************************************
extension UIView{
    
    func cornerRound(RoundingCorners corners: UIRectCorner, radius: CGFloat) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

//***************************************
// MARK: - Segment underline
//***************************************
extension UIView{
    func highlightSelectedSegment(segment : UISegmentedControl){
        let lineWidth: CGFloat = UIScreen.main.bounds.width / CGFloat(segment.numberOfSegments)
        let lineHeight: CGFloat = 5.0
        let lineXPosition = CGFloat(segment.selectedSegmentIndex * Int(lineWidth))
        let lineYPosition = self.frame.size.height - 4.0
        let underlineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underlineFrame)
        underLine.backgroundColor = .white // bottom line color
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    func underlinePosition(segment : UISegmentedControl){
        guard let underLine = self.viewWithTag(1) else {return}
        let xPosition = (self.bounds.width / CGFloat(segment.numberOfSegments)) * CGFloat(segment.selectedSegmentIndex)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            underLine.frame.origin.x = xPosition
        })
    }
} // End of the UISegmentControl Extension

//***************************************
// MARK: - UISegment Extension for underline selected segment
//***************************************
extension UISegmentedControl{
    
    func addUnderlineForSelectedSegment(){
        //        removeBorder()
        if let _ = self.viewWithTag(1) {
            
        } else {
            let underlineWidth: CGFloat = (self.bounds.size.width / CGFloat(self.numberOfSegments)) - 8
            let underlineHeight: CGFloat = 15.0
            let underlineXPosition = (CGFloat(selectedSegmentIndex * Int(underlineWidth))) + 4
            let underLineYPosition = self.bounds.size.height - 1.0
            let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight - 18)
            let underline = UIView(frame: underlineFrame)
            underline.backgroundColor = UIColor.white
            underline.tag = 1
            self.addSubview(underline)
        }
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = ((self.bounds.size.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)) + 4
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

//***************************************
// MARK: - UILabel line spacing
//***************************************
extension UILabel {
    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

//***************************************
// MARK: - UITextField - add right icon
//***************************************
extension UITextField{
    func addRightIcon(isEmpty : Bool,hide : Bool = false){
        self.rightViewMode = UITextField.ViewMode.always
        let someView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        var image = UIImage()
        if isEmpty{
            image = UIImage(named: GlobalIcons.emptyTextFieldIcon)!
        }else{
            image = UIImage(named: GlobalIcons.filledTextFieldIcon)!
        }
        if hide{
            image = UIImage()
        }
        imageView.image = image
        someView.addSubview(imageView)
        self.rightView = someView
    }
}

//***************************************
// MARK: - Validations - email
//***************************************
class ValidateInputs: NSObject {
    
    //***************************************
    // MARK: - Email Validation
    //***************************************
    static func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}

//***************************************
// MARK: - Alert's button tint and background color set
//***************************************
extension UIAlertController{
    //set actionsheet button's tint color
    func addAction(_ action: UIAlertAction, textColor: UIColor?) {
        if let getTextColor = textColor {
            action.setValue(getTextColor, forKey: "titleTextColor")
        }
        addAction(action)
    }
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
}

//***************************************
// MARK: - UIButton - set underline,set radio button UI
//***************************************
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
