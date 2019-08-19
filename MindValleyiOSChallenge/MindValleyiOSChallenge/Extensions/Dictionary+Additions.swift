//
//  Dictionary+Additions.swift
//  Lango
//
//  Created by Asif Bilal on 20/12/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import Foundation


extension Dictionary {
    
    func nullKeyRemoval() -> Dictionary {
        
        var dict = self
        
        for (key, value) in dict {
            
            if value is Dictionary {
                
                let innerDict = value as! Dictionary
                dict.updateValue(innerDict.nullKeyRemoval() as! Value, forKey: key)
                
            }
            
            else {
                
                let keysToRemove = dict.keys.filter { dict[$0] is NSNull }
                
                for key in keysToRemove {
                    
                    dict.removeValue(forKey: key)
                    
                }
                
            }
            
        }
        
        return dict
    }
    
    
}


extension Dictionary where Value:Comparable {
    
    var valuesOrdered:[Value] {
        
        return self.values.sorted()
        
    }
    
}


extension Dictionary where Key:Comparable {
    
    var keysOrdered:[Key] {
        
        return self.keys.sorted()
        
    }
}


extension Dictionary where Key == String, Value == AnyObject? {
    
    func addIfNew(key:String, value:AnyObject){
        
        print("new item added: \(key) with value: \(value)")
        
    }
    
}
