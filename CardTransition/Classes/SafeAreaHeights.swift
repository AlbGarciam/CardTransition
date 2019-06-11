//
//  SafeAreaHeights.swift
//  Sound
//
//  Created by Alberto García-Muñoz on 10/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

var topSafeAreaHeight: CGFloat {
    var height = UIApplication.shared.statusBarFrame.size.height
    if #available(iOS 11.0, *) {
        height += UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
    return height
}

var bottomSafeAreaHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    return 0
}
