//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SystemConfiguration

extension UIViewController {
    
    //***********************************************
    //MARK: - Drawer Functions
    //***********************************************
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "drawer")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
//        self.slideMenuController()?.addLeftGestures()
//        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    //***********************************************
    //MARK: - Display Back Button
    //***********************************************
    func addBackButton(isMenu : Bool) {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backButton.setTitle("", for: .normal)
        backButton.frame = CGRect(x: 10, y: 0, width: 30, height: 30)// CGRe
        backButton.setTitleColor(backButton.tintColor, for: .normal) // You can change the TitleColor
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
        if isMenu{
            backButton.tag = 1
        }
        else
        {
            backButton.tag = 0
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    //***********************************************
    //MARK: - Back Button Action
    //***********************************************
    @IBAction func backAction(_ sender: UIButton) {
        
        if sender.tag == 0 {
            let _ = self.navigationController?.popViewController(animated: true)
        }
        else
        {
        }
    }
}

