//
//  BottomOverlayTransitionHandler.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

open class BottomOverlayTransitionHandler : NSObject, UIViewControllerTransitioningDelegate {
    
    public let isInteractive: Bool
    public let dimmedColor: UIColor
    
    private let presentTransition: BottomOverlayPresentTransition
    private let dismissTransition: BottomOverlayDismissTransition
    private var interactor: BottomOverlayDismissInteractor?
    
    public init(presented: BottomOverlay, interactive: Bool, dimmedColor: UIColor, duration: TimeInterval) {
        self.isInteractive = interactive
        self.dimmedColor = dimmedColor
        self.presentTransition = BottomOverlayPresentTransition(duration: duration)
        self.dismissTransition = BottomOverlayDismissTransition(duration: duration)
        self.interactor = BottomOverlayDismissInteractor(presentedViewController: presented)
        super.init()
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let presented = presented as? BottomOverlay else { return nil }
        return BottomOverlayPresentationController(presentedViewController: presented,
                                                   presenting: presenting,
                                                   dimmedColor: dimmedColor)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractive ? interactor : nil
    }
}
