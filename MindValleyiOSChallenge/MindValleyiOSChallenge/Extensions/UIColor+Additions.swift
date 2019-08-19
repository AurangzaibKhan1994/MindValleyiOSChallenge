//
//  UIColor+Additions.swift
//  Generics
//
//  Created by Usman Tarar on 01/08/2017.
//  Copyright © 2017 Usman Tarar. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    // Color from Hex
    class func colorHexInt(hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        
        let color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        
        return color
    }
    
    
    class func colorHexString(hex: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hex: hex))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
        
    }
    
    class func intFromHexString(hex: String) -> UInt32 {
        
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hex)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
        
    }

    
    static func color(r: Float, g: Float, b: Float, alpha: CGFloat = 1.0) -> UIColor {
        
        return UIColor(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: alpha)
        
    }
    
    static func visconnBlue() -> UIColor{
        
        return UIColor.init(red: 0, green: 61.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    }
    
    static func visconnOrange() -> UIColor{
        
        return UIColor.init(red: 0.976, green: 0.367, blue: 0.302, alpha: 1.0)
    }
}
