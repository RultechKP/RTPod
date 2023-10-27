//
//  BaseAPIClass.swift
//  SionoApp
//
//  Created by Anurag Gupta on 2022-02-28.
//


import Foundation
import Reachability
import KRProgressHUD
import Alamofire


public class BaseAPIClass {
    
    public init(){}

   public static let instance = BaseAPIClass()
   
    //***************************************
    // MARK: - Post Webservice call
    //***************************************
public func kpTest() -> String{
        return "BaseClass Function called"
    }
    
    public func callService(method : HTTPMethod, url: String, param: [String:AnyObject] = [:], isShowHud: Bool = true,isuseheader: Bool = false, onSuccess: @escaping([String:AnyObject]) -> Void, onFailure: @escaping(String) -> Void)
    {
        if isShowHud
        {
            KRProgressHUD.show()
        }else
        {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                KRProgressHUD.dismiss()
            }
        }
        
        let reachability = try! Reachability()
        //
        if(reachability.connection != .unavailable)
        {
            print(param)
            
            var headerdic : HTTPHeaders? = nil
            if(isuseheader == true)
            {
                //                headerdic = HTTPHeaders(["Authorization" : "Bearer " + getUserToken(),"Accept": "application/json"])
            }
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in param {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
                
            },to: url, usingThreshold: UInt64.init(),
                      method: .post,
                      headers: headerdic, requestModifier: { $0.timeoutInterval = 30 }).response{ response in
                print("Server Debug - status code of API - " + "\(url)" + "\(String(describing: response.response?.statusCode.description))")
                
                switch response.result {
                case .success(let result):
                    print(result?.description as Any)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Response: \(json ?? "")")
                        let dic = self.convertToDictionary(text: json ?? "")
                        if let check = dic?["result"] as? Bool{
                            if check{
                                onSuccess(dic! as [String : AnyObject])
                            }else{
                                if let msg = dic?["message"] as? String{
                                    if msg == GlobalTexts.dataNotFound{
                                        onSuccess(dic! as [String : AnyObject])
                                    }else{
                                        onFailure(msg)
                                    }
                                }else{
                                    onFailure(GlobalTexts.serverSideFailureMessage)
                                }
                            }
                        }else{
                            if let msg = dic?["message"] as? String{
                                onFailure(msg)
                            }else{
                                onFailure(GlobalTexts.serverSideFailureMessage)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    onFailure(error.errorDescription!)
                }
            }
        }else {
            if isShowHud{
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    KRProgressHUD.dismiss()
                }
            }
            onFailure(GlobalTexts.noInternet)
        }
    }
    
    public func callGETService(method : HTTPMethod, url: String, param: [String:AnyObject] = [:], isShowHud: Bool = true,isuseheader: Bool = false ,onSuccess: @escaping([String:AnyObject]) -> Void, onFailure: @escaping(String) -> Void)
    {
        
        if isShowHud
        {
            KRProgressHUD.show()
        }else
        {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                KRProgressHUD.dismiss()
            }
        }
        
        let reachability = try! Reachability()
        //
        if(reachability.connection != .unavailable)
        {
            print(param)
            
            var headerdic : HTTPHeaders? = nil
            if(isuseheader == true)
            {
                //                headerdic = HTTPHeaders(["Authorization" : "Bearer " + getUserToken(),"Accept": "application/json"])
            }
            
            AF.request(url, method: method, parameters: nil,encoding: JSONEncoding.default, headers: headerdic, requestModifier: { $0.timeoutInterval = 30 }).responseJSON {
                response in
                
                print("Server Debug - status code of API - " + "\(url)" + "\(String(describing: response.response?.statusCode.description))")
                switch response.result {
                case .success(let result):
                    print(result)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    if let resDict = result as? [String:AnyObject]{
                        if let check = resDict["result"] as? Bool{
                            if check{
                                onSuccess(resDict)
                            }else{
                                if let msg = resDict["message"] as? String{
                                    onFailure(msg)
                                }else{
                                    onFailure(GlobalTexts.serverSideFailureMessage)
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    onFailure(error.errorDescription!)
                }
            }
            
        }else {
            if isShowHud{
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    KRProgressHUD.dismiss()
                }
            }
            onFailure(GlobalTexts.noInternet)
        }
    }
    
    public  func callUploadService(audioType : String = "",fileName : String = "",image : UIImage = UIImage(),audioUrl : URL = URL(fileURLWithPath: ""), url: String, param: [String:AnyObject] = [:], isShowHud: Bool = true,isProfilePicUpload : Bool = false,isFullAudioUpload : Bool = false,isMusicCoverPhotoUpload : Bool = false, onSuccess: @escaping([String:AnyObject]) -> Void, onFailure: @escaping(String) -> Void)
    {
        
        if isShowHud{
            KRProgressHUD.show()
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                KRProgressHUD.dismiss()
            }
        }
        let reachability = try! Reachability()
        if(reachability.connection != .unavailable)
        {
            var headerdic : HTTPHeaders? = nil
            //            headerdic = HTTPHeaders(["Authorization" : "Bearer " + getUserToken(),"Content-type": "multipart/form-data","Accept": "application/json"])
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in param {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                if isProfilePicUpload{
                    multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "profile_image", fileName: "kp.png", mimeType: "image/png")
                }else if isFullAudioUpload {
                    let audioData = NSData(contentsOf: audioUrl)
                    multipartFormData.append(audioData! as Data, withName: "filename", fileName: fileName, mimeType: "audio/\(audioType)")
                }else if isMusicCoverPhotoUpload{
                    multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "cover_image", fileName: "kp.png", mimeType: "image/png")
                }
                
            },to: url, usingThreshold: UInt64.init(),
                      method: .post,
                      headers: headerdic, requestModifier: { $0.timeoutInterval = 30 }).response{ response in
                print("Server Debug - status code of API - " + "\(url)" + "\(String(describing: response.response?.statusCode.description))")
                
                switch response.result {
                case .success(let result):
                    print(result?.description as Any)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Response: \(json ?? "")")
                        let dic = self.convertToDictionary(text: json ?? "")
                        if let check = dic?["result"] as? Bool{
                            if check{
                                onSuccess(dic! as [String : AnyObject])
                            }else{
                                if let msg = dic?["message"] as? String{
                                    onFailure(msg)
                                }else{
                                    onFailure(GlobalTexts.serverSideFailureMessage)
                                }
                            }
                        }else{
                            if let msg = dic?["message"] as? String{
                                onFailure(msg)
                            }else{
                                onFailure(GlobalTexts.serverSideFailureMessage)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    onFailure(error.errorDescription!)
                }
            }
        }else {
            if isShowHud{
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    KRProgressHUD.dismiss()
                }
            }
            onFailure(GlobalTexts.noInternet)
        }
    }
    
    public  func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public func callUploadServiceEditProfile(audioType : String = "",fileName : String = "",image : UIImage = UIImage(),bio : String,userID : Int,audioUrl : URL = URL(fileURLWithPath: ""), url: String, param: [String:AnyObject] = [:], isShowHud: Bool = true,isProfilePicUpload : Bool = false,isFullAudioUpload : Bool = false,isMusicCoverPhotoUpload : Bool = false, onSuccess: @escaping([String:AnyObject]) -> Void, onFailure: @escaping(String) -> Void)
    {
        let parametersPAss = ["bio":bio,"user_id":String(userID)] as [String : AnyObject]
        
        if isShowHud{
            KRProgressHUD.show()
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                KRProgressHUD.dismiss()
            }
        }
        let reachability = try! Reachability()
        if(reachability.connection != .unavailable)
        {
            var headerdic : HTTPHeaders? = nil
            //            headerdic = HTTPHeaders(["Authorization" : "Bearer " + getUserToken(),"Content-type": "multipart/form-data","Accept": "application/json"])
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in parametersPAss {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                //                let newData : Data = image.pngData()!
                if isProfilePicUpload{
                    multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "profile_image", fileName: "kp.png", mimeType: "image/png")
                }else if isFullAudioUpload {
                    let audioData = NSData(contentsOf: audioUrl)
                    multipartFormData.append(audioData! as Data, withName: "filename", fileName: fileName, mimeType: "audio/\(audioType)")
                }else if isMusicCoverPhotoUpload{
                    multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "cover_image", fileName: "kp.png", mimeType: "image/png")
                }
                
            },to: url, usingThreshold: UInt64.init(),
                      method: .post,
                      headers: headerdic, requestModifier: { $0.timeoutInterval = 30 }).response{ response in
                print("Server Debug - status code of API - " + "\(url)" + "\(String(describing: response.response?.statusCode.description))")
                
                switch response.result {
                case .success(let result):
                    print(result?.description as Any)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Response: \(json ?? "")")
                        let dic = self.convertToDictionary(text: json ?? "")
                        if let check = dic?["result"] as? Bool{
                            if check{
                                onSuccess(dic! as [String : AnyObject])
                            }else{
                                if let msg = dic?["message"] as? String{
                                    onFailure(msg)
                                }else{
                                    onFailure(GlobalTexts.serverSideFailureMessage)
                                }
                            }
                        }else{
                            if let msg = dic?["message"] as? String{
                                onFailure(msg)
                            }else{
                                onFailure(GlobalTexts.serverSideFailureMessage)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    if isShowHud{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            KRProgressHUD.dismiss()
                        }
                    }
                    onFailure(error.errorDescription!)
                }
            }
        }else {
            if isShowHud{
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    KRProgressHUD.dismiss()
                }
            }
            onFailure(GlobalTexts.noInternet)
        }
    }
}

//***************************************
// MARK: - Global Texts Constants
//***************************************
struct GlobalTexts {
    static let serverSideFailureMessage = "Something went wrong! Please try again later."
    static let dataNotFound = "Data not found"
    static let noInternet = "No Internet"
    static let goToSettings = Locale.localize("goToSettings")
    static let cameraAccessDenied = Locale.localize("cameraAccessDenied")
    static let error = Locale.localize("error")
    static let chooseFrom = Locale.localize("chooseFrom")
    static let camera = Locale.localize("camera")
    static let cameraNotAvailable = Locale.localize("cameraNotAvailable")
    static let photos = Locale.localize("photos")
    static let others = Locale.localize("others")
}
