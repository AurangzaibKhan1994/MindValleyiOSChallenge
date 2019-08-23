//
//  UIImage+Additions.swift
//  Lango
//
//  Created by Asif Bilal on 10/08/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var kAvatarImage : UIImage {
        get{
            return self.init(imageLiteralResourceName: "Avatar")
        }
    }
    
    fileprivate class func resolveAdaptiveImageName(_ nameStem: String) -> String {
        let height = UIScreen.main.bounds.size.height
        
        if height > 568.0 {
            // Oversize @2x will be used for iPhone 6, @3x for iPhone 6+
            // iPads... we'll work that out later
            if height > 667.0 {
                return nameStem + "-oversize@3x"
            }else {
                return nameStem + "-oversize"
            }
        }
        return nameStem
    }
    
    class func adaptiveImageNamed(_ name: String) -> UIImage? {
        return UIImage(named: resolveAdaptiveImageName(name))
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 0,y :size.height - lineWidth), size: CGSize(width: size.width, height: lineWidth)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        self.init(data: imageData)
    }
}
