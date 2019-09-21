//
//  BottomOverlayProtocol.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

public typealias BottomOverlay = UIViewController & BottomOverlayProtocol

public protocol BottomOverlayProtocol: class {
    func bottomOverlayWidth() -> CGFloat
    func bottomOverlayHeight(for width: CGFloat) -> CGFloat
    func dimmedViewTapped()
}

public extension BottomOverlayProtocol where Self: UIViewController {
    func bottomOverlayWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func bottomOverlayHeight(for width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        return view.systemLayoutSizeFitting(size,
                                            withHorizontalFittingPriority: .required,
                                            verticalFittingPriority: .defaultLow).height
    }
    
    func dimmedViewTapped() {}
}
