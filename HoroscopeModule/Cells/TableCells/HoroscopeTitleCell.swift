//
//  HoroscopeTitleCell.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit
import AlamofireImage

struct HoroscopeTitleViewModel {
    let zodiacName: String?
    let zodiacPeriod: String?
    let zodiacImage: String?
    let date: String?
    let rating: Float?
    let zodiacSegments: [HoroscopeSegment]?
    var selectedIndex: Int = 0
}

struct HoroscopeSegment {
    let segmentName: String?
    let period: HoroscopePeriod?
}

protocol HoroscopeTitleCellDelegate: class {
    func selectedZodiacSegment(_ zodiacSegment: HoroscopeSegment, index: Int)
}

class HoroscopeTitleCell: UITableViewCell {
    
    
    @IBOutlet weak var zodiacDate: UILabel!
    @IBOutlet weak var segmentControlObj: UISegmentedControl!
    @IBOutlet weak var zodiacPeriod: UILabel!
    @IBOutlet weak var zodiacName: UILabel!
    @IBOutlet weak var zodiacImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    weak var delegate: HoroscopeTitleCellDelegate?
    var segments: [HoroscopeSegment] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.zodiacImageView.setCircularView()
        segmentControlObj.addTarget(self, action: #selector(HoroscopeTitleCell.clickedSegment(_:)), for: .valueChanged)
    }
    
    func updateUserInteface(viewModel: HoroscopeTitleViewModel, selectedIndex: Int) {
        self.zodiacName.text = viewModel.zodiacName
        
        if let url = URL(string: viewModel.zodiacImage ?? "") {
            self.zodiacImageView.af_setImage(withURL: url)
        }
        self.zodiacPeriod.text = viewModel.zodiacPeriod
        self.zodiacDate.text = viewModel.date
        self.ratingLabel.text = "\(viewModel.rating ?? 0)/5"
        
        segmentControlObj.removeAllSegments()
        segments = []
        
        if viewModel.zodiacSegments != nil {
            for segment in viewModel.zodiacSegments!.enumerated() {
                segmentControlObj.insertSegment(withTitle: segment.element.segmentName, at: segment.offset, animated: false)
                segments.append(segment.element)
            }
        }
        segmentControlObj.selectedSegmentIndex = selectedIndex
    }
    
    @objc func clickedSegment(_ segmentControl: UISegmentedControl) {
        selectedSegment(index: segmentControl.selectedSegmentIndex)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func selectedSegment(index: Int) {
        delegate?.selectedZodiacSegment(segments[index], index: index)
    }
}
