//
//  BottomOverlayPresentationController.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

open class BottomOverlayPresentationController: UIPresentationController {
    
    public let dimmedColor: UIColor
    open fileprivate(set) var dimmedView: UIView!
    
    public init(presentedViewController: BottomOverlay, presenting: UIViewController?, dimmedColor: UIColor) {
        self.dimmedColor = dimmedColor
        super.init(presentedViewController: presentedViewController, presenting: presenting)
        setupDimmedView()
    }
    
    override open func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        let height = (presentedViewController as? BottomOverlay)?.bottomOverlayHeight() ?? 0
        let presentingBounds = presentingViewController.view.bounds
        
        let origin = CGPoint(x: 0, y: presentingBounds.height - height)
        let size = CGSize(width: presentingBounds.width, height: height)
        
        return CGRect(origin: origin, size: size)
    }
    
    open override func dismissalTransitionWillBegin() {
        updateDimmedAlpha(0)
    }
    
    open override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmedView, at: 0)
        updateDimmedAlpha(0.5)
    }
    
    private func updateDimmedAlpha(_ alpha: CGFloat) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmedView.alpha = alpha
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmedView.alpha = alpha
        })
    }
    
    @objc fileprivate func dimmedViewTapped(_ tap: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

private extension BottomOverlayPresentationController {
    func setupDimmedView() {
        dimmedView = UIView()
        dimmedView.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        dimmedView.backgroundColor = dimmedColor
        dimmedView.alpha = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.isUserInteractionEnabled = true
        dimmedView.addGestureRecognizer(tapGesture)
    }
}
