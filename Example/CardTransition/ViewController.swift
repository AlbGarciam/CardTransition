//
//  ViewController.swift
//  CardTransition
//
//  Created by alb.garciam@gmail.com on 06/11/2019.
//  Copyright (c) 2019 alb.garciam@gmail.com. All rights reserved.
//

import UIKit
import CardStyleTransition

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller = SecondViewController()
        present(controller, animated: true, completion: nil)
    }
}
