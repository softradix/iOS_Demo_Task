//
//  APIManager.swift
//  SupremeEmotions
//
//  Created by anand singh on 06/03/21
//

import UIKit
import Alamofire
//Session

class APIManager: NSObject {
    
    static var sessionManager:Session = {
        let sesionManager = Session.default
        return sesionManager
    }()
    
    class func sendRequest(urlPath:String, type:HTTPMethod, parms:Parameters?, success:((_ responseObject:[String : Any],_ suces:Bool)->Void)!, faliure:((_ errMsg:String,_ errCode:Int)->Void)!) {
        
        if !NetworkReachabilityManager()!.isReachable {
            faliure(Constant.ValidationMessages.internetAppearOffline, -1009)
            return
        }
        
        var request = URLRequest.init(url:URL.init(string: urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        let headers = ["Content-Type": "application/json" ]
        request.httpMethod = type.rawValue
        if !parms!.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parms ?? [:])
        }
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
                if let responseObj:[String:Any] = response.value as? [String : Any] {
                    success(responseObj,true)
                } else {
                    faliure("Invalid Response", response.response?.statusCode ?? Constant.APIResponseCodes.statusCodeInternalServerError.rawValue)
                }
                break
            case .failure(let error):
                faliure("Invalid Response", response.response?.statusCode ?? Constant.APIResponseCodes.statusCodeInternalServerError.rawValue)
                print(error)
            }
        }
    }
    
    class func networkConnected() -> Bool {
        return (NetworkReachabilityManager()?.isReachable)!
    }
}

