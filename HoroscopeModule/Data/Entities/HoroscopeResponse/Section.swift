//
//  Section.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 15, 2018

import Foundation

struct Section : Codable {

        let data : String?
        let title : String?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case title = "title"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(String.self, forKey: .data)
                title = try values.decodeIfPresent(String.self, forKey: .title)
        }

}
