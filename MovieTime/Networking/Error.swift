//
//  Error.swift
//  MovieTime
//
//  Created by Mike Conner on 2/26/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonParsingFailure
    case invalidData
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        }
    }
}

