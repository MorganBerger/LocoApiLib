//
//  APIClient.swift
//  Loco API Test
//
//  Created by Morgan Berger on 02/03/2022.
//

import Foundation

extension API {
    var baseURL: URL {
        let baseURL = URL(string: AppConfig.network.baseURL)!
        return baseURL
    }
    
    var endpoint: String {
        switch self {
        case .getAllLocalisables:
            return "/export/all"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var headers: [String: String?] {
        ["If-Modified-Since": UserDefaultsManager.getValue(for: .lastModifiedResponseHeader) as? String]
    }
    
    var getParams: [String: String] {
        switch self {
        default:
            return [
                "key": Bundle.main.locoApiKey ?? "",
                "no-folding": "true"
            ]
        }
    }
}
