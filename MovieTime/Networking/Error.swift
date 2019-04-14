//
//  Error.swift
//  MovieTime
//
//  Created by Mike Conner on 2/26/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case requestFailed = "Request Failed"
    case jsonParsingFailure = "JSON Parsing Failure"
    case invalidStatusCode = "Invalid Status Code"
    case responseUnsuccessful = "Response Unsuccessful"
}

