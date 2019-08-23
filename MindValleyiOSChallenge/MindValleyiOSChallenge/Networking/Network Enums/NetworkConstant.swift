//
//  NetworkConstant.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 19/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import Foundation

var configuration = Configuration()

struct NetworkConstant {
    struct API {
        static var baseURL = configuration.environment.baseURL
    }
    
    struct HTTPHeaderField {
        static var authentication = "Authorization"
        static var contentType = "Content-Type"
        static var acceptType = "Accept"
        static var acceptEncoding = "Accept-Encoding"
    }
    
    struct ContentType {
        static var json = "application/json"
    }
}

enum Environment: String {
    case Release
    
    var baseURL: String {
        switch self {
        case .Release: return "https://pastebin.com/"
        }
    }
    
    static let apiVersion:String = "raw/"
}

struct Configuration {
    lazy var environment: Environment = {
        
        let key = "Configuration"
        let env = Bundle.main.object(forInfoDictionaryKey:key)
        
        if let config = env as? String {
            
            switch config{
            case Environment.Release.rawValue:
                return Environment.Release
            default:
                return Environment.Release
            }
        }
        
        return Environment.Release
    }()
}
