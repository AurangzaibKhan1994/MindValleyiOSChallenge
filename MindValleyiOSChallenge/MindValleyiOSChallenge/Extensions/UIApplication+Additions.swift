//
//  UIApplication+Additions.swift
//  Generics
//
//  Created by Usman Tarar on 01/08/2017.
//  Copyright © 2017 Usman Tarar. All rights reserved.
//

import UIKit

fileprivate let firstLaunchFlag = "isFirstLaunchFlag"


extension UIApplication {
    
    static func isFirstLaunch() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "hasBeenLaunchedBeforeFlag")
        
    }
    
    static func setFirstLaunchBool(bool: Bool) {
        
        UserDefaults.standard.set(bool, forKey: "hasBeenLaunchedBeforeFlag")
        UserDefaults.standard.synchronize()
    }
    
}
