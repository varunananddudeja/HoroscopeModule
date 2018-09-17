//
//  FilterResponse.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

class Filter {
    func filterResponse<T: Codable>(responseData: Data?, error: Error?, completion: @escaping (HoroscopeModuleResponse<T>)->(Void)) {
        
        guard error == nil else {
            DispatchQueue.main.async {
                completion(.fail(.serverError))
            }
            return
        }
        
        if let responseData = responseData {
            if let obj: T? = JSONParser().get(withData: responseData) {
                if obj != nil {
                    DispatchQueue.main.async {
                        completion(.success(obj!))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.fail(.serverError))
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.fail(.parsingError))
                }
            }
        }
    }
}
