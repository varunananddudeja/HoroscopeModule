//
//  HoroscopeGateway.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

class HoroscopeGateway: BaseGateway {
    
    override var headers: [String : String] {
        return super.headers
    }
    
    func getHoroscope(userID: String,completion: @escaping (HoroscopeModuleResponse<HoroscopeResponse>)->(Void)) {
        
        let str = "\(Constants.API.baseDomain)\(Constants.API.Horoscope.getHoroscope)?\(Constants.API.RequestKeys.userId)=\(userID)"
        
        let api = API(method: .get, endpoint: URL(string: str)!, headers: headers, parameters: nil)
        
        NetworkGateway.shared.apiRequest(api: api, onCompletion: { (response, error) in
            Filter().filterResponse(responseData: response, error: error, completion: completion)
        })
    }
    
    func saveHoroscope(userID: String,zodiacID: String, language: String, completion: @escaping (HoroscopeModuleResponse<HoroscopeResponse>)->(Void)) {
        
        let str = "\(Constants.API.baseDomain)\(Constants.API.Horoscope.saveHoroscope)?\(Constants.API.RequestKeys.userId)=\(userID)"
        
        let api = API(method: .post, endpoint: URL(string: str)!, headers: headers, parameters: [Constants.API.RequestKeys.Horoscope.zodiacID : zodiacID, Constants.API.RequestKeys.langauge: language])
        
        NetworkGateway.shared.apiRequest(api: api, onCompletion: { (response, error) in
            Filter().filterResponse(responseData: response, error: error, completion: completion)
        })
    }
}
