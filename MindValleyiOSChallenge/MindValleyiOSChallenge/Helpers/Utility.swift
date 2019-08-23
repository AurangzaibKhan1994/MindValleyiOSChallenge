//
//  Utility.swift


import UIKit


// Class for Utility methods.
public class Utility: NSObject {

    //MARK: - Methods
    
    
    // Execute the close after delay
    public class func delay(seconds delay:Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    } 
    
    
    // Make a phone call on the number
    public class func callPhoneNumber(at number:String) {
        let phoneNumber: String = "tel://\(number.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))";
        
        if let phoneURL:URL = URL(string: phoneNumber), UIApplication.shared.canOpenURL(phoneURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(phoneURL);
            }
        }
    }
    
    
    // Calculate the age with given date
    public class func calculateAge (_ dateOfBirth: Date) -> Int {
        let calendar : Calendar = Calendar.current
        let unitFlags : NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
        let dateComponentNow : DateComponents = (calendar as NSCalendar).components(unitFlags, from: Date())
        let dateComponentBirth : DateComponents = (calendar as NSCalendar).components(unitFlags, from: dateOfBirth)
        
        if ((dateComponentNow.month! < dateComponentBirth.month!) ||
            ((dateComponentNow.month! == dateComponentBirth.month!) && (dateComponentNow.day! < dateComponentBirth.day!))
            ) {
            return dateComponentNow.year! - dateComponentBirth.year! - 1
        } else {
            return dateComponentNow.year! - dateComponentBirth.year!
        }
    }
    
    ///
    public func getVersionNoString() -> String {
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let str = "Staging"
            return str + " V " + version
        }
        
        return "1.0"
        
    }
    
    static func getDate(date:String , format:String ,convertUTCtoCurrent:Bool) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if convertUTCtoCurrent == true {
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        let newDate = formatter.date(from: date)
        
        return newDate ?? Date()
    }
    
    static func getDateFormat(by date:Date, format:String ,convertUTCtoCurrent:Bool) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if convertUTCtoCurrent == true {
            formatter.timeZone = TimeZone.current
        }
        return formatter.string(from: date)
        
    }
    
    static func getDateFormat(date:String ,In inFormat:String , Out outFormat:String ,convertUTCtoCurrent:Bool) -> String {
        
        let date = self.getDate(date: date, format: inFormat, convertUTCtoCurrent: convertUTCtoCurrent)
        let dateToString = self.getDateFormat(by: date, format: outFormat, convertUTCtoCurrent: convertUTCtoCurrent)
        return dateToString
    }
    
}
