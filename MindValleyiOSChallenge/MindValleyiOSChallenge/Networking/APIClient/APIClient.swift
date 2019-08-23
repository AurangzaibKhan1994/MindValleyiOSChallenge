//
//  APIClient.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 20/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class BackEndError: Error {
    var message: [String]
    
    init(_ message: [String]) {
        self.message = message
    }
}

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:Alamofire.URLRequestConvertible, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise { seal in
            
            //            let sessionManager : SessionManager = SessionManager.default
            //
            //            if let user = UserDefaultsManager.retrieveFromDefaults(forDataType: UserProfile.self, withKey: Constant.User.LoggedUserData){
            //                var con = Configuration()
            //
            //
            //                let oauth2 =  OAuth2Handler.init(clientID:"iOS", baseURLString:con.environment.baseURL, accessToken: user.access_token ?? "temporaryAccessToken", refreshToken: nil)
            //
            //                sessionManager.adapter = oauth2
            //                sessionManager.retrier = oauth2
            //
            //            }
            AF.request(route)
                .validate()
                .responseData(completionHandler: { (response) in
                    
                    print("response: ", response)
                    switch response.result{
                    case .success(let data):
                        do {
                            let response = try decoder.decode(T.self, from: data)
                            seal.fulfill(response)
                        }catch{
                            seal.reject(error)
                        }
                        
                    case .failure(let error):
                        if let data = response.data{
                            do {
                                let errorJSON = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:Any]
                                if let messageArray = errorJSON["message"] as? [String]{
                                    seal.reject(BackEndError.init(messageArray))
                                }else{
                                    seal.reject(error)
                                }
                                print(errorJSON)
                            } catch {
                                seal.reject(error)
                            }
                        }
                        // Token has expired
                        // send user to login screen
                        if let aferror = error as? AFError{
                            if aferror.responseCode == 401{
                                // RootNavigator.shared.setLoginRootVC()
                            }
                        }
                        seal.reject(error)
                    }
                })
        }
    }
    
    //    static func encode<T:Codable>(object:T)->Data{
    //        let encoder = JSONEncoder()
    //        let data = try! encoder.encode(object)
    //        return data
    //    }
    
    // ========================= Pinterest module =========================
    
    static func getPinterestData()->Promise<PinterestData>{
        let req = PinterestRouter.getPinterestData
        return performRequest(route: req)
    }
    
    // ============================= The End =============================
} // end class APIClient

