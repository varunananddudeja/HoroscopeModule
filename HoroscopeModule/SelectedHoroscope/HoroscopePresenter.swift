//
//  HoroscopePresenter.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

protocol HoroscopeDisplayLogic: BaseDisplayLogic {
    func displayDatasource(items: [[Any]])
}

class HoroscopePresenter: HoroscopePresenterLogic {
    
    weak var displayLogic: HoroscopeDisplayLogic?
    var datasource: [[Any]] = []
    
    func getUserHoroscopeDetails(_ response: HoroscopeResponse?, selectedIndex: Int) {
        datasource = []
        var modelSections: [Any] = []
        
        let selectedZodiac = response?.results?.zodiacs?.filter({ (zodiac) -> Bool in
            zodiac.id == response?.results?.selectedZodiac
        }).first
        
        var segments: [HoroscopeSegment] = []
        
        if response?.results?.dailyAvailable == true {
            let segment = HoroscopeSegment(segmentName: response?.results?.dailyKey, period: response?.results?.dailyHoroscope?.first)
            segments.append(segment)
        }
        if response?.results?.monthlyAvailable == true {
            let segment = HoroscopeSegment(segmentName: response?.results?.monthKey, period: response?.results?.monthlyHoroscope?.first)
            segments.append(segment)
        }
        if response?.results?.yearlyAvailable == true {
            let segment = HoroscopeSegment(segmentName: response?.results?.yearlyKey, period: response?.results?.yearlyHoroscope?.first)
            segments.append(segment)
        }
        
        let period = segments[selectedIndex].period
        
        // title view model
        
        let titleViewModel = HoroscopeTitleViewModel(zodiacName: selectedZodiac?.title, zodiacPeriod: selectedZodiac?.dateRange, zodiacImage: selectedZodiac?.imageUrl, date: period?.displayDate, rating: period?.ratings, zodiacSegments: segments, selectedIndex: selectedIndex)
        
        modelSections.append(titleViewModel)
        
        // sections view model
        
        if let sections = period?.sections {
            
            for section in sections {
               modelSections.append(HoroscopeSectionViewModel(title: section.title ?? "", description: section.data ?? ""))
            }
        }
        
        // grid view model
        
        if response?.results?.gridAvailable == true {
            if let grids = response?.results?.grid {
                modelSections.append(grids)
            }
        }
        
        datasource.append(modelSections)
        
        // talk to expert view model
        
        let expertViewModel = TalkToExpertViewModel(link: response?.results?.askAstroWebLink ?? "", description: "Talk to our expert Astrologers for any Life Problems", backgroundImage: "")
        
        if response?.results?.horoscopeFirst == false {
            datasource.insert([expertViewModel], at: 0)
        } else {
            datasource.insert([expertViewModel], at: 1)
        }
        
        displayLogic?.displayDatasource(items: datasource)
    }
}
