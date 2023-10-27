//
//  Localization.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-02-28.
//

import Foundation

extension Locale {
    
    static func localize(_ key: String) -> String {
        let langs = ["en"]
        let localeLang = getAppLanguage()
        let language = langs.contains(localeLang) ? localeLang : "en"
        if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
            let bundle = Bundle(path: path)
            let string = bundle?.localizedString(forKey: key, value: nil, table: nil)
            return string ?? key
        } else {
            return key
        }
    }
    
    static func getAppLanguage() -> String {
        if var lang = Locale.preferredLanguages.first {
            if lang.contains("-"), let prefixLang = lang.components(separatedBy: "-").first {
                if prefixLang == "en" || prefixLang == "fr" || prefixLang == "ja" || prefixLang == "es" || prefixLang == "hi" || prefixLang == "de" || prefixLang == "ta" || prefixLang == "te" || prefixLang == "mr"{
                    lang = prefixLang
                }
            }
            return lang
        } else {
            return "en"
        }
    }

    static func returnStringToArray(stringValue:String) -> [String]{
        let array = stringValue.components(separatedBy: ",")
        return array
    }
}
