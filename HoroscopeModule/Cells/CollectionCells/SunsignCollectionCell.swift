//
//  SunsignCollectionCell.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 17/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit
import AlamofireImage

class SunsignCollectionViewModel  {
    let imageUrl: String
    let name: String
    let period: String
    let zodiacInfo: Zodiac
    var selected = false
    
    init(imageUrl: String, name: String, period: String, zodiacInfo: Zodiac, selected: Bool) {
        self.imageUrl = imageUrl
        self.name = name
        self.period = period
        self.zodiacInfo = zodiacInfo
        self.selected = selected
    }
}

class SunsignCollectionCell: UICollectionViewCell {

    @IBOutlet weak var corneredView: CorneredView!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.setCircularView()
        corneredView.layer.borderWidth = 0.5
        corneredView.layer.borderColor = UIColor.lightGray.cgColor
        selectedBackgroundView = CorneredView(frame: self.bounds)
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    func updateUserInterface(viewModel: SunsignCollectionViewModel) {
        if let url = URL(string: viewModel.imageUrl) {
            imgView.af_setImage(withURL: url)
        }
        titleLabel.text = viewModel.name
        periodLabel.text = viewModel.period
        isSelected = viewModel.selected
    }

}
