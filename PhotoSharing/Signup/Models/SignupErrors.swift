//
//  SignupErrors.swift
//  PhotoSharing
//
//  Created by Ayemere  Odia  on 04/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

enum SignupErrors: LocalizedError, Equatable {
    case responseModelParsingError
    case invalidURLStringError
    case failedRequest(description:String)
    
    var errorDescription:String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .responseModelParsingError, .invalidURLStringError :
            return ""
        }
    }
}
