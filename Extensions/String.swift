//
//  String.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-16.
//

import Foundation
import UIKit

extension String{
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
}
extension String {
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[1]) ?? 0
        let seconds = Int(components[2]) ?? 0
        return (hours * 3600) + (minutes * 60) + seconds
    }
}
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

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

extension String {
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
}

extension String {
    
    func getFormattedDisplayText() -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString.init(string: self)
        let startTag = "<blue>"
        let endTag = "</blue>"
        
        while mutableAttributedString.string.contains(startTag) && mutableAttributedString.string.contains(endTag){
            let string_to_color = mutableAttributedString.string.slice(from: startTag, to: endTag)
            let range = mutableAttributedString.mutableString.range(of: string_to_color ?? "")
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CommonColors.titleTextColor , range: range)
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
}
extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
}
