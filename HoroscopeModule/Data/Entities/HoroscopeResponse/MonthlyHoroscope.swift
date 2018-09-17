//
//  MonthlyHoroscope.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 15, 2018

import Foundation

struct MonthlyHoroscope : Codable, HoroscopePeriod {

        var displayDate : String?
        var ratings : Float?
        var redirects : [String]?
        var redirectsAvailable : Bool?
        var sections : [Section]?
        var sectionsAvailable : Bool?

        enum CodingKeys: String, CodingKey {
                case displayDate = "display_date"
                case ratings = "ratings"
                case redirects = "redirects"
                case redirectsAvailable = "redirects_available"
                case sections = "sections"
                case sectionsAvailable = "sections_available"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                displayDate = try values.decodeIfPresent(String.self, forKey: .displayDate)
                ratings = try values.decodeIfPresent(Float.self, forKey: .ratings)
                redirects = try values.decodeIfPresent([String].self, forKey: .redirects)
                redirectsAvailable = try values.decodeIfPresent(Bool.self, forKey: .redirectsAvailable)
                sections = try values.decodeIfPresent([Section].self, forKey: .sections)
                sectionsAvailable = try values.decodeIfPresent(Bool.self, forKey: .sectionsAvailable)
        }

}
