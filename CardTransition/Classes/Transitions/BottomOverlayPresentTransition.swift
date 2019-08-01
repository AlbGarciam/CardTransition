//
//  BottomOverlayPresentTransition.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

class BottomOverlayPresentTransition: BaseTransition {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        transitionContext.containerView.addSubview(toVC.view)
        let presentFrame = transitionContext.finalFrame(for: toVC)
        let initialFrame = CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.size.height), size: presentFrame.size)
        toVC.view.frame = initialFrame
        
        let timingFunction = CAMediaTimingFunction(controlPoints: 5/6, 0.2, 2/6, 0.9)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            toVC.view.frame = presentFrame
        }
        CATransaction.setCompletionBlock {
            transitionContext.completeTransition(true)
        }
        CATransaction.commit()
    }
    
}
