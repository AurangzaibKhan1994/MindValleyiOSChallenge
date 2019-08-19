//
//  Storyboarded.swift
//  DL Instructor
//
//  Created by Asad Khan on 3/22/19.
//  Copyright © 2019 Attribes. All rights reserved.
//

import Foundation

import UIKit

enum StoryboardType:String{
    
    case Main
    case LaunchScreen
}

protocol Storyboarded {
    static func instantiate(storyboard: StoryboardType) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(storyboard: StoryboardType = .Main) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
