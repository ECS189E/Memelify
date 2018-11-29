//
//  MLabel.swift
//  Memelify
//
//  Created by Kauana dos Santos on 11/28/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

@IBDesignable  class MLabel: UILabel {

    func setup() {
        if DarkMode.isEnabled() {
            self.textColor = UIColor.white
        } else {
            self.textColor = UIColor.black
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        // Add Observers for dark theme
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Add Observers for dark theme
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }

    @objc private func darkModeEnabled(_ notification: Notification) {
        setup()
    }

    @objc private func darkModeDisabled(_ notification: Notification) {
        setup()
    }

    override func awakeFromNib() {
        setup()
    }

    override func prepareForInterfaceBuilder() {
        setup()
    }
}
