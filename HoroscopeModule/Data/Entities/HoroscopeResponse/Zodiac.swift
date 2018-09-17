//
//  Zodiac.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 15, 2018

import Foundation

struct Zodiac : Codable {

        let dateRange : String?
        let enable : Bool?
        let id : Int?
        let imageUrl : String?
        let title : String?

        enum CodingKeys: String, CodingKey {
                case dateRange = "date_range"
                case enable = "enable"
                case id = "id"
                case imageUrl = "image_url"
                case title = "title"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                dateRange = try values.decodeIfPresent(String.self, forKey: .dateRange)
                enable = try values.decodeIfPresent(Bool.self, forKey: .enable)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
                title = try values.decodeIfPresent(String.self, forKey: .title)
        }

}
