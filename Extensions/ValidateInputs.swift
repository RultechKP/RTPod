//
//  ValidateInputs.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-16.
//

import Foundation

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

