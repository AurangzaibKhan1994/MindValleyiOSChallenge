//
//  String+Additions.swift
//  Lango
//
//  Created by Asif Bilal on 01/08/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import Foundation


extension String {
    
    var length: Int { return count}
    
    mutating func removeFirstCharacter() -> Character {
        
        return remove(at: startIndex)
        
    }
    
    func characterAtIndex(_ index: Int) -> Character {
        
        return self[characters.index(startIndex, offsetBy: index)]
        
    }
    
    func removeAllBlankSpaces() -> String {
        
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
        
    }
    
    func isValidPhone() -> Bool {
        
//        let PHONE_REGEX = "^((03))[0-9]{6,14}$"
        let PHONE_REGEX = "^((3))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
        
    }
    
    
    func isEmail() -> Bool {
        
        let EMAIL_REGEX = "^([^@\\s]+)@((?:[-a-z0-9]+\\.)+[a-z]{2,})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        return predicate.evaluate(with: self)
        
    }
    
    
    func removingWhitespaces() -> String {
        
        return components(separatedBy: .whitespaces).joined()
        
    }
    
    mutating func insertCharacter(_ character: Character, atIndex index: Int) -> () {
        
        guard index < length else { return }
        insert(character, at: self.index(startIndex, offsetBy: 4))
        
    }
    
    func dateFromString(_ pattern:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        return dateFormatter.date(from: self)
        
    }
    
    func exclude(_ char:String) -> String {
        
        return self.replacingOccurrences(of: char, with: "")
        
    }
    
    func replaceAll(_ char:String, string:String) -> String {
        
        return self.replacingOccurrences(of: char, with: string)
        
    }
    
    func alphabetsOnly() -> String {
        
        return (self.components(separatedBy:NSCharacterSet.letters.inverted)).joined(separator: "")

    }
    
    func numericOnly() -> String {
        
        return (self.components(separatedBy:NSCharacterSet.decimalDigits.inverted)).joined(separator: "")
        
    }
    
    func safelyLimitedTo(length n: Int)->String {
        let c = self
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    func stripURLFromQR() -> String?{
        
        let qrhash = self
        
       return qrhash.components(separatedBy: "app/").last
    }
    
//    func sizeOfString(usingFont font: UIFont) -> CGSize {
//        let fontAttributes = [NSAttributedStringKey.font: font]
//        return self.size(withAttributes: fontAttributes)
//    }
}
