//
//  BaseLayoutView.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit

@IBDesignable
class BaseLayoutView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    private func initializeView() {
        backgroundColor = .clear
        setMargins()
    }
    
    func setMargins() {
        layoutMargins = UIEdgeInsets(top: verticalMargins, left: horizontalMargins, bottom: verticalMargins, right: horizontalMargins)
    }
    
    @IBInspectable var horizontalMargins: CGFloat = 15 {
        didSet {
            setMargins()
        }
    }
    
    @IBInspectable var verticalMargins: CGFloat = 15 {
        didSet {
            setMargins()
        }
    }
}

