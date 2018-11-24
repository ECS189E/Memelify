//
//  FancyButton.swift
//  Memelify
//
//  Created by David Garwood on 11/22/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class FancyButton: UIButton {

    @IBInspectable dynamic var cornerRadius: CGFloat = 20.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable dynamic var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable dynamic var verticalInset: CGFloat = 10.0 {
        didSet {
            contentEdgeInsets.top = verticalInset
            contentEdgeInsets.bottom = verticalInset
        }
    }
    @IBInspectable dynamic var horizontalInset: CGFloat = 20.0 {
        didSet {
            contentEdgeInsets.left = horizontalInset
            contentEdgeInsets.right = horizontalInset
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    func _init() {
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        contentEdgeInsets.top = verticalInset
        contentEdgeInsets.bottom = verticalInset
        contentEdgeInsets.left = horizontalInset
        contentEdgeInsets.right = horizontalInset
    }
    
    private var normalAlpha: CGFloat = 1
    private var highlightedAlpha: CGFloat = 0.2
//    private var borderColorAlpha: CGFloat? {
//        get {
//            return layer.borderColor?.alpha
//        }
//        set {
//            if let borderColor = layer.borderColor,
//                let newAlpha = newValue {
//                layer.borderColor = UIColor(cgColor: borderColor).withAlphaComponent(CGFloat(newAlpha)).cgColor
//            }
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
