//
//  SegmentControl.swift
//  MedMeanings
//
//  Created by Anurag Gupta on 2022-08-25.
//

import Foundation
import UIKit
//***************************************
// MARK: - Segment white underline
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
