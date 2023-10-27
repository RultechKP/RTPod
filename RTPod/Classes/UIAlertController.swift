//
//  UIAlertController.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-21.
//

import Foundation
import UIKit

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
