//
//  UIScrollView+Additions.swift
//  Lango
//
//  Created by Usman Tarar on 7/11/17.
//  Copyright © 2017 Usman Tarar. All rights reserved.
//

import UIKit


extension UIScrollView {
 
    func scrollToTop() {
        
        setContentOffset(CGPoint.zero, animated: true)
        
    }
    
    func scrollToBottom() {
        
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: true)
        
    }
    
    var isAtTop: Bool {
        
        return contentOffset.y <= verticalOffsetForTop
        
    }
    
    var isAtBottom: Bool {
        
        return contentOffset.y >= verticalOffsetForBottom
        
    }
    
    var verticalOffsetForTop: CGFloat {
        
        let topInset = contentInset.top
        return -topInset
        
    }
    
    var verticalOffsetForBottom: CGFloat {
        
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
        
    }

}


