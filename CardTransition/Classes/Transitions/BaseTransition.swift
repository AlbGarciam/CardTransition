//
//  BaseTransition.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

class BaseTransition : NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
