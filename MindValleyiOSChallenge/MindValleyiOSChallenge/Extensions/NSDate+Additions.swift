//
//  NSDate+Additions.swift
//  Lango
//
//  Created by Asif Bilal on 01/08/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import Foundation


extension Date {
    
    var millisecondsSince1970:Double {
        return Double((self.timeIntervalSince1970 * 1000.0))
        //RESOLVED CRASH HERE
    }
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    init(milliseconds:Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000.0))
    }
    
    func formattedDate(_ pattern:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.string(from: self)
        
    }
    
    func formattedDate(_ style:DateFormatter.Style) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.string(from: self)
        
    }
    
    func isDateInToday() -> Bool {
        
        return Calendar.current.isDateInToday(self)
        
    }
    
    func isSmallerThanDate(_ date: Date) -> Bool {
        
        let intervalBetweenDates = date.timeIntervalSince(self)
        let secondsInMinute: Double = 60
        let secondsBetweenDates = intervalBetweenDates / secondsInMinute
        if secondsBetweenDates >= 0 { return true}
        
        return false
    }
    
    func differenceFromDate(_ anotherDate: Date) -> Date {
        
        let differnceInSeconds = timeIntervalSince(anotherDate)
        return Date(timeIntervalSinceReferenceDate: differnceInSeconds)
        
    }
    
    func getDayMonthYear() -> (day: Int, month: Int, year: Int) {
        
        let calendar = (Calendar.current as NSCalendar).components([.day, .month, .year], from: self)
        return (calendar.day!, calendar.month!, calendar.year!)
    }
    
    func stringFromDate(_ pattern:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        return dateFormatter.string(from: self)
    }
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            
            return "\(components.year!) " + "years ago"
            
        }
        else if (components.year! >= 1){
            
            if (numericDates){
                
                return "1 " + "year ago"
                
            }
            else {
               
                return "year ago"
                
            }
            
        }
        else if (components.month! >= 2) {
            
            return "\(components.month!) " + "months ago"
            
        }
        else if (components.month! >= 1) {
            
            if (numericDates){
                
                return "1 " + "month ago"
                
            }
            else {
                
                return "month ago"
                
            }
            
        }
        else if (components.weekOfYear! >= 2) {
            
            return "\(components.weekOfYear!) " + "weeks ago"
            
        }
        else if (components.weekOfYear! >= 1) {
            if (numericDates) {
                
                return "1 " + "week ago"
                
            }
            else {
                
                return "last week"
                
            }
            
        }
        else if (components.day! >= 2) {
            
            return "\(components.day!) " + "days ago"
            
        }
        else if (components.day! >= 1) {
            
            if (numericDates){
                
                return "1 " + "day ago"
                
            }
            else {
                
                return "yesterday"
                
            }
        }
        else if (components.hour! >= 2) {
            
            return "\(components.hour!) " + "hours ago"
            
        }
        else if (components.hour! >= 1) {
            
            if (numericDates){
                
                return "1 " + "hour ago"
                
            }
            else {
                
                return "an hour ago"
                
            }
        }
        else if (components.minute! >= 2) {
            
            return "\(components.minute!) " + "minutes ago"
            
        }
        else if (components.minute! >= 1) {
            
            if (numericDates){
                
                return "1 " + "minute ago"
                
            }
            else {
              
                return "a minute ago"
            }
            
        }
        else if (components.second! >= 3) {
            
            return "\(components.second!) " + "seconds ago"
            
        } else {
            
            return "just now"
            
        }
        
    }
    
    
    func convertSecnodsIntoTimeComponents(_ num_seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        
        var num_seconds = num_seconds
        
        let hours: Int = num_seconds / (60 * 60)
        num_seconds -= hours * (60 * 60);
        let minutes = num_seconds / 60
        num_seconds -= minutes * 60
        let seconds = num_seconds
        
        return (hours, minutes, seconds)
    }
    
     func currentLocalDate(pattern : String) -> Date {
        
        let date = self
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        let defaultTimeZoneStr = dateFormatter.string(from: date)
        // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        dateFormatter.timeZone = TimeZone.current
        let localTimeZoneStr : String? = dateFormatter.string(from: date)
        
        
        
        var dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = pattern
    
        // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        dateFormatter1.timeZone = TimeZone.current
        
        let localDate : Date? = dateFormatter1.date(from: localTimeZoneStr!)
        
        return (localDate?.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT())))!
    }
    
    func combineDateWithTime(date: Date, time: Date) -> Date? {
        let calendar = NSCalendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var mergedComponments = DateComponents()
        mergedComponments.year = dateComponents.year!
        mergedComponments.month = dateComponents.month!
        mergedComponments.day = dateComponents.day!
        mergedComponments.hour = timeComponents.hour!
        mergedComponments.minute = timeComponents.minute!
        mergedComponments.second = timeComponents.second!
        
        return calendar.date(from: mergedComponments)
    }
    
}
