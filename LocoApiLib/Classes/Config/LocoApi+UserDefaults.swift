//
//  LocoAPI+UserDefaults.swift
//  Loco API Test
//
//  Created by Morgan Berger on 11/03/2022.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {
    case lastModifiedResponseHeader
    case languagesDictionaries
    case currentLanguageCode
}

enum UserDefaultsManager {
    public static func save(value: Any?, for key: UserDefaultsKey) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    public static func getValue(for key: UserDefaultsKey) -> Any? {
        let userDefaults = UserDefaults.standard
        return userDefaults.value(forKey: key.rawValue)
    }
    
    public static func removeValue(for key: UserDefaultsKey) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    public static func removeAllKeys() {
        UserDefaultsKey.allCases.forEach {
            UserDefaultsManager.removeValue(for: $0)
        }
    }
}
