//
//  HoroscopeModuleResponse.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import Foundation

enum HoroscopeModuleResponse<T> {
    case success(T)
    case fail(HoroscopeError)
}

enum HoroscopeError: Error  {
    case serverError
    case parsingError
}
