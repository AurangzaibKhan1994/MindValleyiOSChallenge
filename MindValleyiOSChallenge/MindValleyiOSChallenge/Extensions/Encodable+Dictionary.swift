//
//  Encodable+Dictionary.swift
//  QulabroProject
//
//  Created by Asad Khan on 1/12/19.
//  Copyright © 2019 Mobitribe. All rights reserved.
//

import Foundation


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

