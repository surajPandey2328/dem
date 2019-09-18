//
//  ArticleNetworkManager.swift
//  Article
//
//  Created by Suraj on 10/09/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import MKProgress

typealias CompletionBlock = (JSON, NSError?) -> Void

class ArticleWebServices {
    
    static let shared = ArticleWebServices()
    var viewController = UIViewController()
    
    enum EndPoint: String {
        case registration = "/v1/register"
        case login = "/v1/login"
        case kStreams = "/v1/kstream"
        
        var latestUrl: String {
            return "\(Constants.Api.articleUrl)\(self.rawValue)"
        }
    }
}

extension NSError {
    
    convenience init(localizedDescription: String) {
        self.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    convenience init(code: Int, localizedDescription: String) {
        self.init(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

extension ArticleWebServices {
   
    
    func Registration(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        print(EndPoint.registration.latestUrl)
        postRequest(showHud: false, showHudText: "", endPoint: EndPoint.registration.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func login(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        print(EndPoint.login.latestUrl)
        postRequest(showHud: false, showHudText: "", endPoint: EndPoint.login.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
   
    func getFavArticles( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        print(EndPoint.kStreams.latestUrl)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer H5X1Hmd9GasItkzZMI5tElzcHds9KEQiIBI8KOXNBhDhPuvWWHBvGabUlxf7",
            "Accept": "application/json"
        ]

        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: EndPoint.kStreams.latestUrl, parameters: [:], headers:headers, completion: completion)
    }
    
 
    
    static func showIndicator(_ showHud: Bool) {
        MKProgress.config.circleBorderWidth = 2.0
        MKProgress.config.logoImageSize = CGSize(width: 30, height: 30)
        MKProgress.config.backgroundColor = .clear
        // MKProgress.config.logoImage = GoTasker.Image.loderLogo
        MKProgress.config.circleRadius = 25
        MKProgress.config.height = 60
        MKProgress.config.width = 60
        MKProgress.config.cornerRadius = 30
        if showHud {
            DispatchQueue.main.async {
                MKProgress.show()
            }
        }
    }
    
    static func removeIndicator() {
        DispatchQueue.main.async {
            MKProgress.hide()
        }
    }
    
    func handleFailureBlock(error: NSError) {
        ArticleWebServices.removeIndicator()
        if error.code == -1009 {
            viewController.noInternetConnection()
        } else if error.code == 405 {
            //  UserManager.instance.moveToLogin()
        } else if error.code == 402 {
            // UserManager.instance.moveToLogin()
        } else {
            if error.localizedDescription == "cancelled" {
                return
            }
            viewController.showAlertViewWithMessageAndActionHandler(message: error.localizedDescription, actionHandler: nil)
        }
    }
    
   
    func getRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, pageNumber: Int = 1, controller: UIViewController, endPoint: String, parameters: JSONDictionary, headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
        ArticleApiManager.GET(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, headers: headers, success: { (json) in
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
            ArticleWebServices.removeIndicator()
            shouldErrorRequired ? completion(JSON([:]), error) : self.handleFailureBlock(error: error)
        }
    }
    
    func postRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, endPoint: String, controller: UIViewController, parameters: JSONDictionary, imageData: Data = Data(), imageKey: String = "", headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
        ArticleWebServices.showIndicator(showHud)
        ArticleApiManager.POST(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, imageData: imageData, imageKey: imageKey, headers: headers, success: { (json) in
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
            ArticleWebServices.removeIndicator()
            shouldErrorRequired ? completion(JSON([:]), error) : self.handleFailureBlock(error: error)
        }
    }
    
    func handlecompletionResponse(_ json: JSON, shouldErrorRequired: Bool = false, completion: @escaping CompletionBlock) {
        if json["success"] == true {
            completion(json, nil)
        }
        else if json["status"] == "true" {
            completion(json["user"], nil)
        }
        else if json["message"].count > 2 {
            completion(json, nil)
        }
        else {
            let errorDict = json["error"].dictionaryValue
            if let errorMessageArray = errorDict["error_messages"], let errorCode = errorDict["error_code"], errorMessageArray.count > 0 {
                let errorMessage = errorMessageArray[0]
                let error = NSError(code: errorCode.intValue, localizedDescription: errorMessage.rawString() ?? "")
                //                if error.code == 402 || error.code == 405 {
                //                    handleFailureBlock(error: error)
                //                    return
                //                }
                shouldErrorRequired ? completion(JSON([:]), error) : handleFailureBlock(error: error)
            }
        }
    }
    
}
