//
//  RouterConstants.swift
//  Qulabro
//
//  Created by Asad Khan on 7/24/18.
//  Copyright © 2018 Asad Khan. All rights reserved.
//

import Foundation

enum AppMode: Int {
    case development = 0, staging = 1, live, local
}

var defaultServer = AppMode.development

var appMode:AppMode{
    
    set{
        defaultServer = newValue
    }get{
        return defaultServer
    }
}


struct Router {
    
    struct Server {
        
        static var baseURL: String {
            
            var baseUrl = ""
            
            switch appMode {
            case .development:
                baseUrl = "https://qulabro-ror.attribes.com/api/v2/" // "https://qulabro.attribes.com/v1"
            case .staging:
                baseUrl = "https://qa-api.visconn.com/api/v2/" // "https://visconn.attribes.com/v1"
            case .live:
                baseUrl = ""
                
            case .local:
                baseUrl = ""
            }
            
            return baseUrl
        }
    }
    
    struct APIParameterKey {
        static let user_password = "password"
        static let email = "email"
        static let deviceType = "device_type"
        static let code = "verification_code"
        static let userID = "user_id"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let companyName = "name"
        static let companyContactNumber = "contactNumber"
        static let companyID = "company_id"
        static let workspace = "workspace"
        static let invites  = "emails"
        static let fcmToken = "fcm_token"
        static let status = "status"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
