//
//  Result.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 15, 2018

import Foundation

struct Result : Codable {

        let askAstroWebLink : String?
        let astroEntity : Int?
        let contentLanguage : Int?
        let dailyAvailable : Bool?
        let dailyHoroscope : [DailyHoroscope]?
        let dailyKey : String?
        let deeplink : String?
        let grid : [Grid]?
        let gridAvailable : Bool?
        let horoscopeFirst : Bool?
        let monthKey : String?
        let monthlyAvailable : Bool?
        let monthlyHoroscope : [MonthlyHoroscope]?
        let selectedZodiac : Int?
        let shareText : String?
        let userZodiacAvailable : Bool?
        let yearlyAvailable : Bool?
        let yearlyHoroscope : [YearlyHoroscope]?
        let yearlyKey : String?
        let zodiacs : [Zodiac]?

        enum CodingKeys: String, CodingKey {
                case askAstroWebLink = "ask_astro_web_link"
                case astroEntity = "astro_entity"
                case contentLanguage = "content_language"
                case dailyAvailable = "daily_available"
                case dailyHoroscope = "daily_horoscope"
                case dailyKey = "daily_key"
                case deeplink = "deeplink"
                case grid = "grid"
                case gridAvailable = "grid_available"
                case horoscopeFirst = "horoscope_first"
                case monthKey = "month_key"
                case monthlyAvailable = "monthly_available"
                case monthlyHoroscope = "monthly_horoscope"
                case selectedZodiac = "selected_zodiac"
                case shareText = "share_text"
                case userZodiacAvailable = "user_zodiac_available"
                case yearlyAvailable = "yearly_available"
                case yearlyHoroscope = "yearly_horoscope"
                case yearlyKey = "yearly_key"
                case zodiacs = "zodiacs"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                askAstroWebLink = try values.decodeIfPresent(String.self, forKey: .askAstroWebLink)
                astroEntity = try values.decodeIfPresent(Int.self, forKey: .astroEntity)
                contentLanguage = try values.decodeIfPresent(Int.self, forKey: .contentLanguage)
                dailyAvailable = try values.decodeIfPresent(Bool.self, forKey: .dailyAvailable)
                dailyHoroscope = try values.decodeIfPresent([DailyHoroscope].self, forKey: .dailyHoroscope)
                dailyKey = try values.decodeIfPresent(String.self, forKey: .dailyKey)
                deeplink = try values.decodeIfPresent(String.self, forKey: .deeplink)
                grid = try values.decodeIfPresent([Grid].self, forKey: .grid)
                gridAvailable = try values.decodeIfPresent(Bool.self, forKey: .gridAvailable)
                horoscopeFirst = try values.decodeIfPresent(Bool.self, forKey: .horoscopeFirst)
                monthKey = try values.decodeIfPresent(String.self, forKey: .monthKey)
                monthlyAvailable = try values.decodeIfPresent(Bool.self, forKey: .monthlyAvailable)
                monthlyHoroscope = try values.decodeIfPresent([MonthlyHoroscope].self, forKey: .monthlyHoroscope)
                selectedZodiac = try values.decodeIfPresent(Int.self, forKey: .selectedZodiac)
                shareText = try values.decodeIfPresent(String.self, forKey: .shareText)
                userZodiacAvailable = try values.decodeIfPresent(Bool.self, forKey: .userZodiacAvailable)
                yearlyAvailable = try values.decodeIfPresent(Bool.self, forKey: .yearlyAvailable)
                yearlyHoroscope = try values.decodeIfPresent([YearlyHoroscope].self, forKey: .yearlyHoroscope)
                yearlyKey = try values.decodeIfPresent(String.self, forKey: .yearlyKey)
                zodiacs = try values.decodeIfPresent([Zodiac].self, forKey: .zodiacs)
        }

}
