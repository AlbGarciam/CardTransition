//
//  BottomOverlayProtocol.swift
//  CardStyleTransition
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//

import UIKit

public typealias BottomOverlay = UIViewController & BottomOverlayProtocol

public protocol BottomOverlayProtocol: class {
    func bottomOverlayHeight() -> CGFloat
}

public extension BottomOverlayProtocol where Self: UIViewController {
    func bottomOverlayHeight() -> CGFloat {
        return view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
