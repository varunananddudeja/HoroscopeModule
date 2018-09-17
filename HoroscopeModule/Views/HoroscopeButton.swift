//
//  HoroscopeButton.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 17/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    
    override func awakeFromNib() {
        setAppearence()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearence()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setAppearence()
    }
    
    private func setAppearence() {
        layer.borderWidth = 1
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        layer.cornerRadius = 5
        contentEdgeInsets = UIEdgeInsetsMake(5,8,5,8)
        setTitleColor(#colorLiteral(red: 0.968627451, green: 0.5843137255, blue: 0.4392156863, alpha: 1), for: .normal)
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.968627451, green: 0.5843137255, blue: 0.4392156863, alpha: 1):UIColor.white
            layer.borderColor = isSelected ? #colorLiteral(red: 0.968627451, green: 0.5843137255, blue: 0.4392156863, alpha: 1):UIColor.gray.cgColor
        }
    }
}
