//
//  ActivityIndicatorView.swift
//  TestAppD2
//
//  Created by Vladimir Stepanchikov on 18.07.2021.
//  Copyright © 2021 Григорий Соловьев. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
    static func setupUI(for activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.style = .gray
        let bounds: CGRect = UIScreen.main.bounds
        activityIndicatorView.center = CGPoint(x: bounds.size.width / 2,
                                               y: bounds.size.height / 2)
        activityIndicatorView.hidesWhenStopped = true
    }
}
