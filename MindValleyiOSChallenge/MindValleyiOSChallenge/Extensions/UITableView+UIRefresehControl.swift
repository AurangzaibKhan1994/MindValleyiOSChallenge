//
//  UITableView+UIRefresehControl.swift
//  Lango
//
//  Created by Fahid Attique on 4/18/17.
//  Copyright © 2017 Asif Bilal. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // Add to Table View
    
    func addRefreshControl(_ refresher: UIRefreshControl, withSelector selector:Selector) {
        
        refresher.addTarget(nil, action: selector, for: .valueChanged)
        if #available(iOS 10.0, *) {
            refreshControl = refresher
        } else {
            addSubview(refresher)
        }
    }
    
    
    func tableViewScrollToBottom(animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
            self.isHidden = false
        }
    }
    
    func indexPath(for view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: location)
    }
    
}
