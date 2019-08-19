//
//  LoginRouter.swift
//  Qulabro
//
//  Created by Asad Khan on 7/24/18.
//  Copyright © 2018 Asad Khan. All rights reserved.
//

import Foundation
//import Alamofire

enum LoginRouter: APIConfiguration{
    
    case login(email:String, password:String,device_type:String)
    case setFCM(token:String)
    case logout
    case updateStatus(statusID: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .login,.setFCM,.logout,.updateStatus:
            return .post
            //        case .logout:
            //            return .post // .delete
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "users/signin" // "/auth/login"
        case .logout:
            return "users/signout" // "/auth/logout"
        case .setFCM:
            return "users/profile/update_fcm_token" // "/permissions"
        case .updateStatus:
            return "users/profile/update_status"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password,let type):
            return [Router.APIParameterKey.email: email, Router.APIParameterKey.user_password: password,Router.APIParameterKey.deviceType: type]
        case .logout:
            return nil
        case .setFCM(let token):
            return [Router.APIParameterKey.fcmToken: token, Router.APIParameterKey.deviceType: AppConstant.deviceType]
        case .updateStatus(let statusID):
            return [Router.APIParameterKey.status: statusID]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Router.Server.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Authorization Header
        switch self {
        case .login:
            break
        default:
            
            if let authorization = UserDefaults.standard.string(forKey:HTTPHeaderField.authentication.rawValue){
                urlRequest.setValue(authorization
                    , forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }
        }
        
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
