//
//  Constant.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21
//

import Foundation
import UIKit

class Constant {
    
    private enum BaseUrl: String {
        case production = "https://tenpercent-interview-project.s3.amazonaws.com/"
    }
    
    struct APIConstantNames {
        static let baseUrl = BaseUrl.production.rawValue
        static let urlPathGetTopics = APIConstantNames.baseUrl + "topics.json"
        static let urlPathGetMeditations = APIConstantNames.baseUrl + "meditations.json"
    }
    
    struct ValidationMessages {
        public static let internetAppearOffline = "You’re not connected to the Internet.\nPlease connect and retry."
        public static let oopsTitle = "Oops...!"        
    }
    
    struct AppColor {
        static let colorAppTheme = UIColor.withHex(hex: "261D77", alpha: 1.0)
    }
    
    enum APIResponseCodes : Int {
        // The request was successfully completed
        case statusCodeSuccessful = 200
        
        case statusCodeNoContentSuccessful = 204
        
        //The request was not completed due to an internal error on the server side
        case statusCodeInternalServerError = 500
        
        case success = 1
        
    }
    
    struct AppFont {
        static let fontRegular = "GillSans"
        static let fontLight = "GillSans-Light"
        static let fontBold = "GillSans-Bold"
        static let fontSemibold = "GillSans-Semibold"
    }
    
    struct AppFontHelper {
        static func defaultRegularFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: AppFont.fontRegular, size: size)!
        }
        static func defaultBoldFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: AppFont.fontBold, size: size)!
        }
        static func defaultSemiboldFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: AppFont.fontSemibold, size: size)!
        }
        static func defaultLightFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: AppFont.fontLight, size: size)!
        }
    }
    
}

