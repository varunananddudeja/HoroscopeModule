//
//  HoroscopeResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 15, 2018

import Foundation

struct HoroscopeResponse : Codable {

        let results : Result?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case results = "results"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            results = try values.decodeIfPresent(Result.self, forKey: .results)
            success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
