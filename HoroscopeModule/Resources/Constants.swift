//
//  Constants.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

enum Constants {
    enum API {
        
        static let baseDomain = "http://13.126.238.171/api/"
        
        enum Horoscope {
            static let getHoroscope = "get_horoscope_v2/"
            static let saveHoroscope = "user/save_zodiac/"
        }
        
        enum RequestKeys {
            
            static let userId = "uid"
            static let langauge = "language"
            
            enum Horoscope {
                static let zodiacID = "zodiac_id"
            }
        }
    }
    
    enum Test {
        static let uid = "testhoguid"
    }
}
