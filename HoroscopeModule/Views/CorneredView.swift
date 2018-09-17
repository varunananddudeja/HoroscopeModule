//
//  CorneredView.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit

class CorneredView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    private func initializeView() {
        layer.cornerRadius = 6.0
        layer.contentsScale = UIScreen.main.scale
        layer.rasterizationScale = UIScreen.main.scale
        clipsToBounds = true
    }
}
