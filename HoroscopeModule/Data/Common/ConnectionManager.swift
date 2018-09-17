//
//  ConnectionManager.swift
//  ImageSearchApp
//
//  Created by Varun Dudeja on 14/07/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation
import Alamofire

struct API {
    var method: HTTPMethod
    var endpoint: URL
    var headers: [String: String]
    var parameters: [String: Any]?
}

class NetworkGateway {
    
    static let shared = NetworkGateway()
    let queue = DispatchQueue(label: "com.varun.response-queue", qos: .utility, attributes: [.concurrent])
    
    private init() {}
    
    func apiRequest(api: API, onCompletion:@escaping (_ response: Data?, _ error: Error?) -> ()) {
        
        
        Alamofire.request(api.endpoint, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers).responseData(queue: queue) { (response: DataResponse<Data>) in
            
            switch response.result {
            case .success(_):
                onCompletion(response.result.value, nil)
                
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
        
    }
}

