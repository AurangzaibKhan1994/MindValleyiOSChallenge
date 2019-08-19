//
//  JSONResponse.swift
//  QulabroProject
//
//  Created by Asad Khan on 8/18/18.
//  Copyright © 2018 Hassan. All rights reserved.
//

import Foundation

protocol Response: Codable {
    var success: Bool? {get set}
//    var message: String? {get set}
    var msg: String? {get set}
    
}
