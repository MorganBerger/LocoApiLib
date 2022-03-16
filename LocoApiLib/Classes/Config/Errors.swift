//
//  Errors.swift
//  Loco API Test
//
//  Created by Morgan Berger on 11/03/2022.
//

import Foundation

enum LocalsManagerError: Error {
    case apiKeyNotFound
    case apiKeyEmpty
    case apiError(LocoApiError)
    
    var localizedDescription: String {
        switch self {
        case .apiKeyNotFound:
            return "Loco API key not found! Make sure you added 'loco_api_key' key to your info.plist with the correct value."
        case .apiKeyEmpty:
            return "Loco API key found but is empty. Make sure you fill the correct key value in your info.plist file."
        case .apiError(let error):
            return error.localizedDescription
        }
    }
}

enum LocoApiError: Error {
    case noResponse
    case httpError(statusCode: Int)
    case other(Error)
    case urlNotValid(urlStr: String)
    
    var localizedDescription: String {
        let prefix = "Loco API call failed. Reason -> "
        let unknownProblemStr = "An unknown problem occurred: "
        switch self {
        case .noResponse:
            return unknownProblemStr + "No HTTP response where found."
        case .httpError(let status):
            var msg = prefix + "HTTP status code \(status). "
            switch status {
            case 401:
                msg += "Make sure you added 'loco_api_key' key to your info.plist with the correct value."
            case 304:
                msg += "No modifications found since last requested update."
            default:
                break
            }
            return msg
        case .other(let error):
            return unknownProblemStr + error.localizedDescription
        case .urlNotValid(let urlStr):
            return unknownProblemStr + "Could not create url for string: '\(urlStr)'."
        }
    }
}
