//
//  ViewController.swift
//  RTPod
//
//  Created by RultechKP on 10/18/2023.
//  Copyright (c) 2023 RultechKP. All rights reserved.
//

import UIKit
import RTPod


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let log = Logger()
        log.printLog()

        let frameworkBundle = Bundle(for: Logger.self)
        let path = frameworkBundle.path(forResource: "Resources", ofType: "bundle")
        let resourcesBundle = Bundle(url: URL(fileURLWithPath: path!))
        let image = UIImage(named: "star.png", in: resourcesBundle, compatibleWith: nil)
        BaseAPIClass.instance.callService(method: .post, url: "url", param: [String : String],isShowHud: false, onSuccess: { (resDict) in
            onSuccess(resDict)
        }) { (msg) in
            onFailure(msg)
        }
       
        print(image)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

