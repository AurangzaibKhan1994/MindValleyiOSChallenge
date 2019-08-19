//
//  UIFont+BrownStd.swift
//  Lango
//
//  Created by Asif Bilal on 10/08/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import UIKit


protocol AppFontProtocol {
    static func setCustomFontWith(name: AppFonts, size: CGFloat) -> UIFont!
}


//Enter App Custom Font names
enum AppFonts: String {
    case centuryGothicBold = "GOTHICB",
    centuryGothicRegular = "CenturyGothic"//
   
}


extension UIFont : AppFontProtocol {
        
    static func setCustomFontWith(name: AppFonts, size: CGFloat) -> UIFont! {
        
        return UIFont(name: name.rawValue, size: size)
        
    }
    
    static func setAppRegularFont(size : CGFloat) -> UIFont{
        return UIFont.init(name:"CenturyGothic" , size: size)!
    }
    static func setAppBoldFont(size : CGFloat) -> UIFont{
        return UIFont.init(name:"CenturyGothic-Bold" , size: size)!
    }
//    static func setAppLightFont(size : CGFloat) -> UIFont{
//        return UIFont.init(name:AppFonts.montserratLight.rawValue , size: size)!
//    }
}

