//
//  MeetingTimeRule.swift
//  QulabroProject
//
//  Created by Asad Khan on 10/6/18.
//  Copyright © 2018 Mobitribe. All rights reserved.
//

import Foundation

/**
 `RequiredRule` is a subclass of Rule that defines how a required field is validated.
 */
open class EndTimeRule: Rule {
    /// String that holds error message.
    private var message : String
    /// String that holds start time.
    private var startTime : String
    /**
     Initializes `RequiredRule` object with error message. Used to validate a field that requires text.
     
     - parameter message: String of error message.
     - returns: An initialized `RequiredRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(startTime: String ,message : String = "End time can not be less than start time"){
        self.message = message
        self.startTime = startTime
    }
    
    /**
     Validates a field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    open func validate(_ value: String) -> Bool {
        
        return !value.isEmpty
    }
    
    /**
     Used to display error message when validation fails.
     
     - returns: String of error message.
     */
    open func errorMessage() -> String {
        return message
    }
}
