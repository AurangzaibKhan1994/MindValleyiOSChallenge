//
//  SplashController.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 19/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import UIKit

class SplashController: UIViewController, Storyboarded {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var splashLogo: UIImageView!
    
    weak var coordinator: MainCoordinator?
    
    //    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.Main.rawValue, nil)
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupHeader()
        self.splashLogo.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        showAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
        
    }
    
    func setupHeader()
    {
        self.title = ""
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // animation when logo appears
    func showAnimation()
    {
        self.splashLogo.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1.5, animations: {
            
            self.splashLogo.alpha = 1
            self.splashLogo.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        })
        { (success) in
            Utility.delay(seconds: 2, closure: {
                self.coordinator?.mainController()
            })
        }
    }
    
    // animation when logo dissappears
    func removeAnimation()
    {
        self.splashLogo.transform = CGAffineTransform(scaleX: 5, y: 5)
        
        UIView.animate(withDuration: 3, animations: {
            self.splashLogo.alpha = 0.0
            self.splashLogo.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (success) in
            
        }
    }
} // end class SplashController

