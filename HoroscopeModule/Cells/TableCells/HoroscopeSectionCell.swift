//
//  HoroscopeSectionCell.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit
struct HoroscopeSectionViewModel {
    let title: String
    let description: String
}

class HoroscopeSectionCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUserInterface(viewModel: HoroscopeSectionViewModel) {
        titleLabel.text = viewModel.title
        descLabel.text = viewModel.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
