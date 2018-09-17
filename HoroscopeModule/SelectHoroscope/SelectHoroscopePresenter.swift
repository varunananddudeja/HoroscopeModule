//
//  SelectHoroscopePresenter.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 17/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

protocol SelectHoroscopeDisplayLogic: BaseDisplayLogic {
    func displaySunsigns(list: [SunsignCollectionViewModel], selectedLanguage: Int)
    func displaySuccessSubmission(response: HoroscopeResponse?)
}

class SelectHoroscopePresenter: SelectHoroscopePresenterLogic {
    
    weak var displayLogic: SelectHoroscopeDisplayLogic?
    
    func getSunsigns(from response: HoroscopeResponse?) {
        
        var list: [SunsignCollectionViewModel] = []
        
        if let zodiacs = response?.results?.zodiacs {
            for zodiac in zodiacs {
                
                var isSelected = false
                if zodiac.id == response?.results?.selectedZodiac {
                    
                    isSelected = true
                }
                list.append(SunsignCollectionViewModel(imageUrl: zodiac.imageUrl ?? "", name: zodiac.title ?? "", period: zodiac.dateRange ?? "", zodiacInfo: zodiac, selected: isSelected))
            }
        }
        
        if response?.results?.selectedZodiac == nil {
            list.first?.selected = true
        }
        
        displayLogic?.displaySunsigns(list: list, selectedLanguage: response?.results?.contentLanguage ?? 1)
    }
    
    func sunsignSelected(datasource: [SunsignCollectionViewModel], language: Int) {
        guard let selectedZodiacID = datasource.filter({$0.selected}).first?.zodiacInfo.id else {
           return
        }
        
        HoroscopeGateway().saveHoroscope(userID: Constants.Test.uid, zodiacID: "\(selectedZodiacID)", language: "\(language)") {[weak self] (response) -> (Void) in
            switch response {
            case .fail(let error):
                self?.displayLogic?.displayError(error: error)
            case .success(let dta):
                self?.displayLogic?.displaySuccessSubmission(response: dta)
            }
        }
    }
}
