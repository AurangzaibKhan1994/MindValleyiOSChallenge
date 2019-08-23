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
                baseUrl = ""
            case .staging:
                baseUrl = ""
            case .live:
                baseUrl = ""
                
            case .local:
                baseUrl = ""
            }
            
            return baseUrl
        }
    }
    
    struct APIParameterKey {
        static let email = "email"
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
