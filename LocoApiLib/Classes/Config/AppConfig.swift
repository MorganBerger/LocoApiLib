//
//  AppConfig.swift
//  Loco API Test
//
//  Created by Morgan Berger on 02/03/2022.
//

import Foundation

enum AppConfig {
    enum network {
        static let scheme = "https://"
        static let host = "localise.biz"
        static let suffix = "/api"
        static let baseURL = scheme + host + suffix
    }
}
