//
//  Coordinator.swift
//  DL Instructor
//
//  Created by Asad Khan on 3/22/19.
//  Copyright © 2019 Attribes. All rights reserved.
//

import Foundation

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

