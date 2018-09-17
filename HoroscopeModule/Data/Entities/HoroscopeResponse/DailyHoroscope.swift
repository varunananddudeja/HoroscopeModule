//
//  DailyHoroscope.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

protocol HoroscopePeriod {
    var displayDate : String? {set get}
    var ratings : Float? {set get}
    var redirects : [String]? {set get}
    var redirectsAvailable : Bool? {set get}
    var sections : [Section]? {set get}
    var sectionsAvailable : Bool? {set get}
}

struct DailyHoroscope : Codable, HoroscopePeriod {
    
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
