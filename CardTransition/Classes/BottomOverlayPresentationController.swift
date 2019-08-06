//
//  BottomOverlayPresentationController.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

open class BottomOverlayPresentationController: UIPresentationController {
    
    public let dimmedColor: UIColor
    public let indicatorColor: UIColor
    public let cornerRadius: CGFloat
    open fileprivate(set) var dimmedView: UIView!
    
    public init(presentedViewController: BottomOverlay, presenting: UIViewController?,
                dimmedColor: UIColor, indicatorColor: UIColor, cornerRadius: CGFloat) {
        self.dimmedColor = dimmedColor
        self.indicatorColor = indicatorColor
        self.cornerRadius = cornerRadius
        super.init(presentedViewController: presentedViewController, presenting: presenting)
        setupDimmedView()
        addTopIndicator()
    }
    
    override open func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmedView.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        if #available(iOS 11.0, *) {
            presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            presentedView?.layer.cornerRadius = cornerRadius
        }
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
        (presentedViewController as? BottomOverlay)?.dimmedViewTapped()
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
    
    func addTopIndicator() {
        guard let presentedView = self.presentedView else { return }
        let indicator = UIView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        indicator.layer.masksToBounds = true
        indicator.layer.cornerRadius = 2
        indicator.backgroundColor = indicatorColor
        
        presentedView.addSubview(indicator)
        
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 80).isActive = true
        indicator.topAnchor.constraint(equalTo: presentedView.topAnchor, constant: 14).isActive = true
        indicator.centerXAnchor.constraint(equalTo: presentedView.centerXAnchor).isActive = true
    }
}
