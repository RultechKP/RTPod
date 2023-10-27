//
//  UIApplication.swift
//  MedMeanings
//
//  Created by Anurag Gupta on 2022-08-29.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView?{
        return value(forKey: "statusBar") as? UIView
    }
}

