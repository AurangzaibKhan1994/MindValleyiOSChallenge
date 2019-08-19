//
//  UIImageView+Additions.swift
//  Generics
//
//  Created by Usman Tarar on 10/08/2017.
//  Copyright © 2017 Usman Tarar. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    // MARK: Specific Methods
    
    func presentViewController(_ viewControllerToPresent: UIViewController) {
        self.presentViewController(viewControllerToPresent, animated: true)
    }
    
    func presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        self.present(viewControllerToPresent, animated: flag) { () -> Void in
            
        }
    }
    
    func dismissViewController(_ completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
    
    @objc func dismissMe() {
        if let navigationViewController = self.navigationController {
            
            if (navigationViewController.viewControllers.count > 1) {
                dismissPushedController()
            } else {
                dismissPresentedController()
            }
            
        } else {
            dismissPresentedController()
        }
    }
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func hideKeyboard() {
        
        view.endEditing(true)
        
    }
    
    func addCancelButton() {
        
        let cancelButton = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(dismissMe))
        navigationItem.leftBarButtonItem = cancelButton
        
    }
    
    class func topVC(_ base: UIViewController? = UIApplication.shared.windows.first!.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topVC(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topVC(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topVC(presented)
        }
        return base
    }
    
    fileprivate func dismissPresentedController() {
        
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    fileprivate func dismissPushedController() {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func showAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        //        self.presentViewController(alertController, animated: true, completion: nil)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showRetryAlertWithCompletionBlock(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: completion))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showRetryAndCancelAlertWithCompletionBlock(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: completion))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertWithCompletionBlock(title: String, message: String,positiveButtonTile : String? = "Ok",negativeButtonTitle:String? = "Cancel", positiveCompletion: ((UIAlertAction) -> Void)? = nil,negativeCompletion:((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        alertController.addAction(UIAlertAction(title: positiveButtonTile!, style: UIAlertActionStyle.default, handler: positiveCompletion))
        
        alertController.addAction(UIAlertAction(title: negativeButtonTitle!, style: UIAlertActionStyle.destructive, handler: negativeCompletion))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertWithCompletionBlock(title: String, message: String,buttonTitle : String? = "OK", completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: buttonTitle!, style: UIAlertActionStyle.default, handler: completion))
        //        self.presentViewController(alertController, animated: true, completion: nil)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertOnSelfWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addGlobalHUDWith(title : String = "", detail : String = "") {
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.mode = MBProgressHUDMode.indeterminate
        progressHUD.label.text = title
        progressHUD.detailsLabel.text = detail
    }

    func hideGlobalHudAddedFromAppDelegate() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
