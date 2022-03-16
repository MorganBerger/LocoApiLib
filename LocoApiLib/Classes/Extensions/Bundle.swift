//
//  Bundle.swift
//  Loco API Test
//
//  Created by Morgan Berger on 14/03/2022.
//

import Foundation

extension Bundle {
    var locoApiKey: String? {
        return object(forInfoDictionaryKey: "loco_api_key") as? String
    }
}
