//
//  GlobalLabelControl.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-03.
//

import Foundation
import UIKit

class UIVerticalAlignLabel: UILabel {
    
    enum VerticalAlignment : Int {
        case VerticalAlignmentTop = 0
        case VerticalAlignmentMiddle = 1
        case VerticalAlignmentBottom = 2
    }
    
    var verticalAlignment : VerticalAlignment = .VerticalAlignmentTop {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)
        
        switch(verticalAlignment) {
        case .VerticalAlignmentTop:
            return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
        case .VerticalAlignmentMiddle:
            return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
        case .VerticalAlignmentBottom:
            return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
        default:
            return bounds
        }
    }
    
    override func drawText(in rect: CGRect) {
        let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: r)
    }
}

class GlobalLabelControl: UILabel {
    
    //***************************************
    // MARK: - System Functions
    //***************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tintColor = GlobalHeadingLabelColorConstants.headingTextColor
        self.font = GlobalHeadingLabelFontFamily.headingLabelFont
        self.backgroundColor = GlobalHeadingLabelColorConstants.headingBackgroundColor
    }
    
    //***************************************
    // MARK: - Other Functions
    //***************************************
    func setLabel(title : String,textColor : UIColor,font : UIFont,backgroundColor : UIColor = UIColor.clear){
        self.text = title
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
    }
    
    //set Heading Label
    func setHeadingLabel(title : String){
        self.text = title
        self.textColor = GlobalHeadingLabelColorConstants.headingTextColor
        self.font = GlobalHeadingLabelFontFamily.headingLabelFont
        self.backgroundColor = GlobalHeadingLabelColorConstants.headingBackgroundColor
    }
    
    //set Sub Heading Label
    func setSubHeadingLabel(title : String,textColor : UIColor = GlobalSubHeadingLabelColorConstants.subHeadingTextColor){
        self.text = title
        self.textColor = textColor
        self.font = GlobalSubHeadingLabelFontFamily.subHeadingLabelFont
        self.backgroundColor = GlobalSubHeadingLabelColorConstants.subHeadingBackgroundColor
    }
    
    //set Toast Label
    func setToastLabel(title : String){
        self.text = title
        self.textColor = GlobalToastLabelColorConstant.toastTintColor
        self.font = GlobalToastLabelFontFamily.toastLabelFont
        self.backgroundColor = GlobalToastLabelColorConstant.toastBackgroundColor
    }
    
    //set time label
//    func setRoundedBackgroundTimeLabel(title : String){
//        self.text = title
//        self.layer.cornerRadius = self.frame.height / 2
//        self.layer.masksToBounds = true
//        self.textColor = UIColor.white
//        self.layer.backgroundColor = GlobalTimeDisplayLabelConstants.backgroundColor
//        self.font = GlobalTimeDisplayLabelConstants.font
//    }
    
    //set rounded UILabel with border
    func setRoundedBorderedLabel(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.backgroundColor = GlobalRoundedCornerLabel.backgroundColor.cgColor
        self.font = GlobalRoundedCornerLabel.font
        self.textColor = UIColor.white
    }
}

public func marginUnits(_ n: Int) -> CGFloat {
    return CGFloat(n * 8)
}

public func prominentSubview(_ prominent: UIView) -> (UITabBarController) -> Void {
    prominent.translatesAutoresizingMaskIntoConstraints = false
    return { controller in
        controller.view.addSubview(prominent)
        NSLayoutConstraint.activate(
            [
                controller.tabBar.centerXAnchor.constraint(equalTo: prominent.centerXAnchor),
                controller.tabBar.topAnchor.constraint(equalTo: prominent.centerYAnchor, constant: marginUnits(-2)),
            ]
        )
        controller.view.bringSubviewToFront(prominent)
    }
}

public func prominentCreationButton(color: UIColor) -> (UIButton) -> Void {
    return { button in
        button.setImage(
            UIImage(named: "Create")?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
//        button.backgroundColor = color ? .init(0xe5e5e5) : .init(0x1b1b1b)
        button.tintColor = color
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: -2)
        button.layer.shadowRadius = marginUnits(1)
        button.layer.shadowColor = UIColor.black.cgColor // TODO: light mode
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        button.sizeToFit()
        NSLayoutConstraint.activate(
            [
                button.heightAnchor.constraint(equalToConstant: 64),
                button.widthAnchor.constraint(equalToConstant: 64),
            ]
        )
    }
}
