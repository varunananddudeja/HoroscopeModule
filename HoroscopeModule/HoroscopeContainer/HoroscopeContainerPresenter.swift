//
//  HoroscopeContainerPresenter.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

protocol BaseDisplayLogic: class {
    func displayError(error: Error)
}

protocol HoroscopeContainerDisplayLogic:BaseDisplayLogic {
    func displayHoroscope(response: HoroscopeResponse, isZodiacAvailable: Bool)
}

class HoroscopeContainerPresenter: HoroscopeContainerPresenterLogic {
    
    weak var displayLogic: HoroscopeContainerDisplayLogic?
    
    func getSelectedZodiac(for UserId: String) {
        HoroscopeGateway().getHoroscope(userID: UserId) {[weak self] (response) -> (Void) in
            switch response {
            case .fail(let error):
                self?.displayLogic?.displayError(error: error)
            case .success(let dta):
                self?.displayLogic?.displayHoroscope(response: dta, isZodiacAvailable: dta.results?.userZodiacAvailable == true)
            }
        }
    }
}
