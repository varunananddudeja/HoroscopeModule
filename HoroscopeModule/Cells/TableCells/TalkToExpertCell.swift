//
//  TalkToExpertCell.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit

struct TalkToExpertViewModel {
    let link: String
    let description: String
    let backgroundImage: String
}

class TalkToExpertCell: UITableViewCell {
    
    @IBOutlet weak var consultNowButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    
    var openUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        consultNowButton.isSelected = true
    }
    
    func updateUserInterface(viewModel: TalkToExpertViewModel) {
        descriptionLabel.text = viewModel.description
        backImage.image = UIImage(named: viewModel.backgroundImage)
        openUrl = viewModel.link
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickedBtnConsultNow(_ sender: Any) {
        guard let url = URL(string: openUrl ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
