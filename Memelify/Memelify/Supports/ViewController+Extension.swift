//
//  LoadingSpinnerExtension.swift
//  Memelify
//
//  Created by Kauana dos Santos on 11/30/18.
//  Copyright © 2018 Memelify. All rights reserved.
// Source: http://brainwashinc.com/2017/07/21/loading-activity-indicator-ios-swift/
//

import Foundation
import UIKit

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 133/255, blue: 145/255, alpha: 1.0)

        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        let center = spinnerView.center
        ai.frame = CGRect(x: center.x - 50, y: center.y - 100, width: 100, height: 100)

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }

    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
