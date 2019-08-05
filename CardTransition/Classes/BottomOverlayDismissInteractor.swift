//
//  BottomOverlayDismissInteractor.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

class BottomOverlayDismissInteractor: UIPercentDrivenInteractiveTransition {
    
    private let MinimumPercentOfVisible: CGFloat = 0.5
    private let SwipeThreshold: CGFloat = 1000
    private weak var presentedViewController: BottomOverlay?
    private weak var transitioningDelegate: BottomOverlayTransitionHandler?
    
    private var currentPercent: CGFloat = 0
    
    init(presentedViewController: BottomOverlay?) {
        self.presentedViewController = presentedViewController
        self.transitioningDelegate = presentedViewController?.transitioningDelegate as? BottomOverlayTransitionHandler
        super.init()
        preparePanGesture(in: presentedViewController?.view)
    }
    
    private func finishAnimation(withVelocity velocity: CGPoint) {
        if currentPercent > MinimumPercentOfVisible || velocity.y > SwipeThreshold {
            finish()
        } else {
            cancel()
        }
    }
    
    private func preparePanGesture(in view: UIView?) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        presentedViewController?.view?.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        let translationY = pan.translation(in: presentedViewController?.view).y
        currentPercent = min(max(translationY/(presentedViewController?.view.frame.size.height ?? 0), 0), 1)
        
        switch pan.state {
        case .began:
            presentedViewController?.dismiss(animated: true, completion: nil)
        case .changed:
            update(currentPercent)
        default:
            let velocity = pan.velocity(in: presentedViewController?.view)
            finishAnimation(withVelocity: velocity)
        }
    }
}
