//
//  GlobalBaseVC.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-03-03.
//

import UIKit
import AVKit
import Reachability
import Mute
import Toast_Swift
import IQKeyboardManagerSwift

class GlobalBaseVC: UIViewController,UITextFieldDelegate{
    
    //***************************************
    // MARK: - Outlets
    //***************************************
    @IBOutlet weak var btnDrawer: UIButton!
    
    //***************************************
    // MARK: - Variables
    //***************************************
    var keyboardStatus = false
    let reachability = try! Reachability()
    var currentPageSize : Int = 50
    let synth = AVSpeechSynthesizer()
    
    //***************************************
    // MARK: - System Functions
    //***************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slideMenuController()?.removeLeftGestures()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.hideKeyboardWhenTappedAround()
        setViewBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.slideMenuController()?.removeLeftGestures()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name:  UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardDidShowNotification, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    if let vcs = self.navigationController?.visibleViewController{
                    }
                    print("Reachable via WiFi")
                } else {
                    if let vcs = self.navigationController?.visibleViewController{
                    }
                    print("Reachable via Cellular")
                }
            }
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
            }
            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    deinit{
        self.reachability.stopNotifier()
    }
    
    //***************************************
    // MARK: - Other Functions
    //***************************************
    @objc func willEnterForeground() {
        checkAppNeedsUpdate()
    }
    
    func checkAppNeedsUpdate() {
        //        let infoDictionary = Bundle.main.infoDictionary
        //        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.adezinesdev.techmeanings")!
        //        //"http://itunes.apple.com/lookup?bundleId=com.electra.littlepesa&country=ke"
        //
        //        guard let data = try? Data(contentsOf: url) else {
        //          print("There is an error!")
        //          return ;
        //        }
        //        let lookup = (try? JSONSerialization.jsonObject(with: data , options: [])) as? [String: Any]
        //        if let resultCount = lookup!["resultCount"] as? Int, resultCount == 1 {
        //            if let results = lookup!["results"] as? [[String:Any]] {
        //                if let appStoreVersion = results[0]["version"] as? String{
        //                    appDelegate.appLatestStoreVersion = appStoreVersion
        //                    var currentVersion = ""
        //                    if let currentVersion1 = infoDictionary!["CFBundleShortVersionString"] as? String{
        //                        currentVersion = currentVersion1
        //                    }
        //                    let versionCompare = currentVersion.compare(appStoreVersion, options: .numeric)
        //                    //userCurrentVersion = 1.0
        //                    //appStoreLatestVersion = 4.1.0
        //                    let firstNumberFromCurrentVersion = Int(currentVersion[0]) ?? 0//1
        //                    let firstNumberAppstoreLatestVersion = Int(appStoreVersion[0]) ?? 0//4
        //
        //                    if firstNumberFromCurrentVersion < firstNumberAppstoreLatestVersion{
        //                        //1<4
        //                        //update force
        //                        showUpdateAlert(forceUpdate: true)
        //                        return
        //                    }
        //
        //                    if versionCompare == .orderedAscending {
        //                        print("user having older than version")
        //                        print("Need to update [\(appStoreVersion) != \(currentVersion)]")
        //                        showUpdateAlert(forceUpdate: false)
        //                        return
        //                    }
        //                }
        //            }
        //        }
        return
    }
    
    func showUpdateAlert(forceUpdate : Bool){
        //        let alertMessage = "A new version of TechMeanings is available,Please update to version " + appDelegate.appLatestStoreVersion;
        //        let alert = UIAlertController(title: "New Version Available", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        //
        //        let okBtn = UIAlertAction(title: "Update Now", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        //            if let url = URL(string:"https://apps.apple.com/app/techmeanings-dictionary/id6449478547"),
        //               UIApplication.shared.canOpenURL(url){
        //                if #available(iOS 10.0, *) {
        //                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //                } else {
        //                    UIApplication.shared.openURL(url)
        //                }
        //            }
        //        })
        //
        //        let laterBtn = UIAlertAction(title: "Update Later", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        //            alert.dismiss(animated: false)
        //        })
        //        alert.addAction(okBtn)
        //        if !forceUpdate{
        //            alert.addAction(laterBtn)
        //        }
        //        self.present(alert, animated: true)
    }
    
    func convertToJSONString(value: [Int]) -> String? {
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch{
            }
        }
        return nil
    }
    
    func setViewBackgroundColor(value : Bool = true){
        if value{
            //            self.view.backgroundColor = .clear// CommonColors.controllerBackgroundColor
        }
    }
    
    func speakText(msg : String){
        checkDeviceVolume()
        let utterance = AVSpeechUtterance(string: msg)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
    }
    
    func checkDeviceVolume(){
        let audioSession = AVAudioSession.sharedInstance()
        var volume: Float?
        do {
            try audioSession.setActive(true)
            volume = audioSession.outputVolume
        } catch {
            print("Error Setting Up Audio Session")
        }
        if volume! < 0.1{
            showCustomToast(message: "Please Increase phone volume.")
        }
        Mute.shared.check()
    }
    
    func shareDetails(msg : String, subjectId: String, wordId: String){
        //        let text = "TechMeanings\n" + APIBaseUrl.rultechShare + "/app?subject_id=\(subjectId)&word_id=\(wordId)" + "\n\n" + msg//Android AppLink:\n https://play.google.com/store/apps/details?id=com.techmeaningsandroidapp" + "\n" + "iOS AppLink:\n https://apps.apple.com/us/app/techmeanings-dictionary/id6449478547" + "\n\n" + msg
        //
        //        let textShare = [ text ]
        //        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        //        activityViewController.popoverPresentationController?.sourceView = self.view
        //        //        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
        //        //        }
        //        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func getSubjectName(fromCategory: String) -> String {
        
        switch fromCategory {
        case "civil": return "Basic Civil Engineering"
        case "chemistry": return "Engineering Chemistry"
        case "electrical": return "Basic Electrical Engineering"
        case "electronics": return "Electronic Devices & Circuits"
        case "environmental": return "Environmental Science"
        case "graphicdesign": return "Engineering Graphics & Design"
        case "mathematics1": return "Maths-1 (Thomson's Calculus)"
        case "mathematics2": return "Maths-2 (Linear Algebra)"
        case "mechanical": return "Basic Mechanical Engineering"
        case "physics": return "Engineering Physics"
        case "programming": return "Programming for Problem Solving"
        case "workshop": return "Workshop Technology"
        default: return fromCategory
        }
    }
    
    //***************************************
    // MARK: - Camera Permission
    //***************************************
    func checkCameraAccess() -> Bool{
        var status = false
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
            status = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                    status = true
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            print("Unknown")
        }
        return status
    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: GlobalTexts.error,
                                                message: GlobalTexts.cameraAccessDenied,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: GlobalTexts.goToSettings, style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:]
                                          , completionHandler: { _ in
                    // Handle
                })
            }
        })
        alertController.addAction(UIAlertAction(title: "cancel", style: .default))
        
        present(alertController, animated: true)
    }
    
    //***************************************
    // MARK: - Show Toast Message Function
    //***************************************
    func showCustomToast(message : String,success : Bool = false,toastDuration : Double = 3.0){
        var style = ToastStyle()
        style.backgroundColor = UIColorFromRGB(rgbValue: 0xa8b7d9)
        style.messageColor = UIColor.black
        style.messageFont = GlobalToastLabelFontFamily.toastLabelFont
        style.imageSize = CGSize(width: 0, height: 0)
        var img = UIImage()
        //        if success{
        //            img = UIImage(named: GlobalIcons.successToast)!
        //        }else{
        //            img = UIImage(named: GlobalIcons.failureToast)!
        //        }
        let windows = UIApplication.shared.windows
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            windows.last?.makeToast(message, duration: toastDuration, position: .bottom,image : img, style: style)//, isImageContain: false)
            windows.last?.makeKeyAndVisible()
        }
    }
    
    //***************************************
    // MARK: - Hide Keyboard
    //***************************************
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GlobalBaseVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        //Do something here
        keyboardStatus = true
        if Keyboard.height == 0.0 || Keyboard.height == 0{
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight = keyboardSize.height + 40
                Keyboard.height = (keyboardHeight)
                //            print(keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillDisappear() {
        //Do something here
        keyboardStatus = false
    }
    
    //***************************************
    // MARK: - UITextField right icon functions
    //***************************************
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text1 = textField.text as NSString?  {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: string)
            if textField.tag == 1{
                
            }else{
                if txtAfterUpdate.count > 0 {
                    textField.addRightIcon(isEmpty: false)
                }else{
                    textField.addRightIcon(isEmpty: true)
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    //***************************************
    // MARK: - IPAddress functions
    //***************************************
    func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                    
                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
    
}
