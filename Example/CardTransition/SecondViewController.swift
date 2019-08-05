//
//  SecondViewController.swift
//  CardTransition_Example
//
//  Created by Alberto García-Muñoz on 01/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CardStyleTransition

class SecondViewController: UIViewController, BottomOverlayProtocol {
    
    var transitionHandler : BottomOverlayTransitionHandler!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitionHandler = BottomOverlayTransitionHandler(presented: self,
                                                                interactive: true,
                                                                dimmedColor: .blue,
                                                                indicatorColor: .yellow,
                                                                duration: 1)
        transitioningDelegate = transitionHandler
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func bottomOverlayHeight() -> CGFloat {
        return 300
    }
}
