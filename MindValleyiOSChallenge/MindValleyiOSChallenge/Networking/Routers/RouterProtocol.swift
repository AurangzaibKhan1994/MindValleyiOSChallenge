//
//  RouterProtocol.swift
//  Qulabro
//
//  Created by Asad Khan on 7/24/18.
//  Copyright © 2018 Asad Khan. All rights reserved.
//

import Foundation
import Alamofire

typealias AlamofireRequestConvertible = URLRequestConvertible

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

