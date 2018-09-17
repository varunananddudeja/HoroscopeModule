//
//  JSONParser.swift
//  ImageSearchApp
//
//  Created by Varun Dudeja on 14/07/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

struct JSONParser {
    
    /// Get Codable Type of Object when you pass the Data
    ///
    /// - Parameter data: Data what you get on Network Response
    /// - Returns: Generic Type<T> i.e. a codable type
    func get<T:Codable>(withData data:Data) -> T? {
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func set<T:Codable>(withObject object:T) -> Data? {
        return try? JSONEncoder().encode(object)
    }
    
}
