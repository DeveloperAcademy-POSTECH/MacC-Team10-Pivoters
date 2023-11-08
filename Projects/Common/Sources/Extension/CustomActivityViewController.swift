//
//  CustomActivityViewController.swift
//  Common
//
//  Created by Ha Jong Myeong on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

// UIActivityViewController 서브클래스
class CustomActivityViewController: UIActivityViewController {
    var onDismiss: (() -> Void)? // 사라질 때 호출될 클로저

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?()
    }
}
