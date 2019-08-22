//
//  MainCoordinator.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 19/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startAuth()
    }
}

// MARK: - Auth
extension MainCoordinator {
    func startAuth() {
        let vc = SplashController.instantiate(storyboard: .Main)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
}

// MARK: - App
extension MainCoordinator {
    func startApp() {
        let vc = SplashController.instantiate(storyboard: .Main)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setupWindow(withRoot: vc)
    }
    
    func mainController(){
        let vc = AdsController.instantiate(storyboard: .Main)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
}

// MARK: - General PushPop
extension MainCoordinator {
    func popCurrentViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func popTo(viewController: UIViewController) {
        navigationController.popToViewController(viewController, animated: true)
    }
    
    func poptoRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func push(viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
