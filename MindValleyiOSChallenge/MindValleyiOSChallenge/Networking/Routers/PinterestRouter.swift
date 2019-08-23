//
//  PinterestRouter.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 20/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import Foundation
import Alamofire

enum PinterestRouter: URLRequestConvertible{
    
    case getPinterestData
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getPinterestData:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getPinterestData:
            return "wgkJgazE"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getPinterestData:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var con = Configuration()
        
        var url = try con.environment.baseURL.asURL().appendingPathExtension(Environment.apiVersion)
        url = url.appendingPathComponent(Environment.apiVersion)
        url = url.appendingPathComponent(path)
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(NetworkConstant.ContentType.json, forHTTPHeaderField:NetworkConstant.HTTPHeaderField.acceptType)
        urlRequest.setValue(NetworkConstant.ContentType.json, forHTTPHeaderField:NetworkConstant.HTTPHeaderField.contentType)
        
        // Authorization Header
        //        if let user = UserDefaultsManager.retrieveFromDefaults(forDataType:UserProfile.self, withKey:Constant.User.LoggedUserData){
        //
        //            urlRequest.setValue("Bearer \(user.access_token!)"
        //                , forHTTPHeaderField: NetworkConstant.HTTPHeaderField.authentication)
        //        }
        
        urlRequest.setValue("Bearer a1b2c3"
            , forHTTPHeaderField: NetworkConstant.HTTPHeaderField.authentication)
        
        // Parameters
        if let parameters = parameters {
            let encoding: ParameterEncoding = {
                switch self {
                    //                case .addPayment, .getLearners:
                //                    return JSONEncoding.default
                default:
                    return URLEncoding.default
                }
            }()
            print(urlRequest)
            return try encoding.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
