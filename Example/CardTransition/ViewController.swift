//
//  ViewController.swift
//  CardTransition
//
//  Created by alb.garciam@gmail.com on 06/11/2019.
//  Copyright (c) 2019 alb.garciam@gmail.com. All rights reserved.
//

import UIKit
import CardTransition

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller = UIViewController()
        controller.view.backgroundColor = .red
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .overCurrentContext
        present(controller, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardTransition(isComplete: false, dismiss: true, duration: 0.5)
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardTransition(isComplete: false, dismiss: false, duration: 0.5)
    }
}
