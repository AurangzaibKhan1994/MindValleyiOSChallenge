//
//  RootNavigator.swift
//  QulabroProject
//
//  Created by Asad Khan on 8/27/18.
//  Copyright © 2018 Mobitribe. All rights reserved.
//

import Foundation
import SideMenu

class RootNavigator{
    
    private init() { }
    
    static let shared = RootNavigator()
    
    func setRootVC() {
        
        if UserDefaults.standard.bool(forKey: AppConstant.isUserRegistered){
            
            let rootNav = UIStoryboard.init(name: "Main", bundle:nil).instantiateInitialViewController() as! UINavigationController
            
            rootNav.popToRootViewController(animated: false)
            
            SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuPresentMode = .viewSlideInOut
            SideMenuManager.default.menuEnableSwipeGestures = false
            
            AppDelegate.shared.window?.rootViewController = rootNav
            
        }else{
            
            let rootVC = UIStoryboard.init(name: "Welcome", bundle:nil).instantiateInitialViewController()
            AppDelegate.shared.window?.rootViewController = rootVC
        }
    }
    
    func setLoginRootVC(){
        UserDefaults.standard.removeObject(forKey: AppConstant.isUserRegistered)
        UserDefaults.standard.removeObject(forKey: HTTPHeaderField.authentication.rawValue)
        self.setRootVC()
    }
}
