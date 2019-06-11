//
//  BaseCustomTransition.swift
//  Sound
//
//  Created by Alberto García-Muñoz on 10/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension UIViewControllerContextTransitioning {
    func getControllers() -> (UIViewController, UIViewController) {
        guard let fromViewController = self.viewController(forKey: .from),
            let toViewController = self.viewController(forKey: .to) else {
                fatalError("Doesn't have from or to controller")
        }
        return (fromViewController, toViewController)
    }
}

public class BaseCustomTransition: NSObject {
    private let isDismissing: Bool
    private let duration: TimeInterval
    init(dismiss: Bool, duration: TimeInterval) {
        isDismissing = dismiss
        self.duration = duration
        super.init()
    }
    
    open func presenting(using transitionContext: UIViewControllerContextTransitioning) {}
    open func dismissing(using transitionContext: UIViewControllerContextTransitioning) {}
}

extension BaseCustomTransition: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isDismissing ? dismissing(using: transitionContext) : presenting(using: transitionContext)
    }
}
