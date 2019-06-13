//
//  CardTransition.swift
//  Sound
//
//  Created by Alberto García-Muñoz on 10/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

public class CardTransition: BaseCustomTransition {
    let isComplete: Bool
    let backgroundColor: UIColor
    let indicatorColor: UIColor
    let shadowColor: UIColor
    let limit: CGFloat
    
    /// Initializer of transition
    ///
    /// - Parameters:
    ///   - isComplete: Determines if presented VC should cover the entire screen
    ///   - dismiss: Determines if is dismiss transition
    ///   - backgroundColor: Card's background color
    ///   - indicatorColor: Card's indicator background color
    ///   - shadowColor: Card's shadow color
    ///   - limit: Percentage of scroll to be done to dismiss VC
    ///   - duration: Transition duration
    public init(isComplete: Bool,
         dismiss: Bool,
         backgroundColor: UIColor = .white,
         indicatorColor: UIColor = .lightGray,
         shadowColor: UIColor = .lightGray,
         limit: CGFloat = 0.75,
         duration: TimeInterval)
    {
        self.isComplete = isComplete
        self.indicatorColor = indicatorColor
        self.shadowColor = shadowColor
        self.backgroundColor = backgroundColor
        self.limit = limit
        super.init(dismiss: dismiss, duration: duration)
    }
    
    private func getBounds(for bounds: CGRect) -> CGRect {
        let origin = CGPoint(x: 0, y: isComplete ? topSafeAreaHeight : (bounds.height-topSafeAreaHeight)/2)
        let size = CGSize(width: bounds.width,
                          height: isComplete ? bounds.height-topSafeAreaHeight : (bounds.height-topSafeAreaHeight)/2)
        return CGRect(origin: origin, size: size)
    }
    
    override public func presenting(using transitionContext: UIViewControllerContextTransitioning) {
        let (fromVC, toVC) = transitionContext.getControllers()
        let containerView = transitionContext.containerView
        fromVC.view.isUserInteractionEnabled = false
        
        let view = BaseCardView(with: toVC,
                                isComplete: isComplete,
                                backgroundColor: backgroundColor,
                                indicatorColor: indicatorColor,
                                shadowColor: shadowColor,
                                limit: limit)
        
        let bounds = view.frame
        containerView.addSubview(view)
        view.frame = bounds.offsetBy(dx: 0, dy: bounds.height+bottomSafeAreaHeight)
        
        let timingFunction = CAMediaTimingFunction(controlPoints: 5/6, 0.2, 2/6, 0.9)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            view.frame = bounds
        }
        CATransaction.setCompletionBlock {
            transitionContext.completeTransition(true)
            containerView.bringSubviewToFront(view)
        }
        CATransaction.commit()
    }
    
    override public func dismissing(using transitionContext: UIViewControllerContextTransitioning) {
        let (fromVC, toVC) = transitionContext.getControllers()
        
        toVC.view.isUserInteractionEnabled = true
        
        let superview = fromVC.view.superview ?? fromVC.view
        let finalFrame = superview?.frame ?? .zero
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            superview?.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height+20)
        }, completion: { (_) in
            transitionContext.completeTransition(true)
        })
    }
}
