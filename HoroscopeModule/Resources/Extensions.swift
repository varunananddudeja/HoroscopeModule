//
//  Extensions.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 17/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func setCircularView() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}

extension BaseVC {
    func showErrorAlert(message: String?) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
}

extension BaseDisplayLogic where Self: BaseVC {
    func displayError(error: Error) {
        showErrorAlert(message: error.localizedDescription)
    }
}
