//
//  NSArray+Additions.swift
//  Lango
//
//  Created by Asif Bilal on 01/08/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import Foundation
import UIKit


extension Array {
    
    mutating func removeObject<T: Equatable> (_ objet: T) -> Bool {
        
        for (idx, objectToCompare) in self.enumerated() {
            
            if let to = objectToCompare as? T {
                
                if objet == to {
                    
                    self.remove(at: idx)
                    return true
                    
                }
                
            }
        }
        
        return false
    }
    
    mutating func appendAtBeginning(newItem : Element){
        
        let copy = self
        self = []
        self.append(newItem)
        self.append(contentsOf: copy)
        
    }
    
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
}
