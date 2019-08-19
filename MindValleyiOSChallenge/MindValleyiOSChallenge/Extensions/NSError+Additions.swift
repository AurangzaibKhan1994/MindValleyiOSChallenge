//
//  NSError+Additions.swift
//  Lango
//
//  Created by Asif Bilal on 01/08/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import Foundation

let appDomain = "com.appDomain"
let generalAppError = "Something went wrong."

extension NSError {
    
    convenience init(errorMessage:String?, code: Int? = nil) {
        
        var errorMessage = errorMessage
        
        if errorMessage == nil {
            errorMessage = generalAppError
        }
        
        var errorCode = -1
        if let code = code { errorCode = code}
        
        self.init(domain: appDomain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage!])
    }
    
}
