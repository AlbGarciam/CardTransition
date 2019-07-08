//
//  BaseCardView.swift
//  Sound
//
//  Created by Alberto García-Muñoz on 10/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class BaseCardView: UIView {
    static func initialFrame(for isComplete: Bool) -> CGRect {
        let bounds = UIScreen.main.bounds
        let height = isComplete ? bounds.height-topSafeAreaHeight : (bounds.height)/2
        let origin = CGPoint(x: 0,
                             y: isComplete ? topSafeAreaHeight : bounds.height-height)
        let size = CGSize(width: bounds.width,
                          height: isComplete ? bounds.height-topSafeAreaHeight : height)
        return CGRect(origin: origin, size: size)
    }
    
    private var indicator: UIView! {
        didSet {
            indicator.backgroundColor = indicatorColor
            indicator.layer.cornerRadius = 2
            indicator.layer.masksToBounds = true
        }
    }
    private weak var controller: UIViewController?
    
    private var backgroundLayer: CALayer!
    private let isComplete: Bool
    private var panGesture: UIPanGestureRecognizer!
    
    private let backgroundLayerColor: UIColor
    private let indicatorColor: UIColor
    private let shadowColor: UIColor
    private let limit: CGFloat

    init(with controller: UIViewController,
         isComplete: Bool, backgroundColor: UIColor,
         indicatorColor: UIColor, shadowColor: UIColor, limit: CGFloat)
    {
        self.controller = controller
        self.isComplete = isComplete
        self.backgroundLayerColor = backgroundColor
        self.shadowColor = shadowColor
        self.indicatorColor = indicatorColor
        self.limit = limit
        super.init(frame: BaseCardView.initialFrame(for: isComplete))
        
        configure()
        
        isUserInteractionEnabled = true
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(gesture:)))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeGestureRecognizer(panGesture)
    }
    
    private func configure() {
        addTopIndicator()
        configureBackgroundLayer()
        clipsToBounds = false
        
        guard let controller = controller else { return }
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(controller.view)
        controller.view.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 16).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        let bottom = controller.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottom.priority = UILayoutPriority(999)
        bottom.isActive = true
        layoutIfNeeded()
        dropShadow()
    }
    
    private func addTopIndicator() {
        indicator = UIView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 80).isActive = true
        indicator.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func configureBackgroundLayer() {
        backgroundLayer = CALayer(layer: layer)
        layer.insertSublayer(backgroundLayer, below: indicator.layer)
        if #available(iOS 11.0, *) {
            backgroundLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            backgroundLayer.cornerRadius = 16
        }
        backgroundLayer.backgroundColor = backgroundLayerColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
    }
    
    private func dropShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: -8)
        layer.shadowRadius = 9
        layer.masksToBounds = false
    }
    
    @objc private func onPanGesture(gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        let initialFrame = BaseCardView.initialFrame(for: isComplete)
        switch gesture.state {
        case .changed:
            let yTranslation = gesture.translation(in: superview).y
            let newHeight = getNewHeight(for: yTranslation, height: initialFrame.height)
            let bounds = UIScreen.main.bounds
            let origin = CGPoint(x: 0, y: bounds.height-newHeight)
            let size = CGSize(width: bounds.width, height: newHeight)
            DispatchQueue.main.async {
                view.frame = CGRect(origin: origin, size: size)
                view.layoutIfNeeded()
            }
        case .ended, .cancelled:
            let shouldDismiss = view.frame.height < limit * initialFrame.height
            if shouldDismiss {
                controller?.dismiss(animated: true, completion: nil)
            } else {
                guard let view = gesture.view as? BaseCardView else { return }
                view.layoutIfNeeded()
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    view.frame = BaseCardView.initialFrame(for: view.isComplete)
                    view.layoutIfNeeded()
                }, completion: nil)
            }
        default:
            break
        }
    }
    
    private func applyBounceFunction(to translation: CGFloat, base: CGFloat) -> CGFloat {
        let numerator = -translation+base
        let log = (1 + log10(numerator/base))
        return base*log
    }
    
    private func getNewHeight(for translation: CGFloat, height: CGFloat) -> CGFloat {
        return translation < 0 ? applyBounceFunction(to: translation, base: height) : (height - translation)
    }
}
