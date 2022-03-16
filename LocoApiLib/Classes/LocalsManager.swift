//
//  Manager.swift
//  Loco API Test
//
//  Created by Morgan Berger on 09/03/2022.
//

import Foundation
import Combine

typealias Translations = [String: String]
typealias RootLanguages = [String: Translations]

final class LocalsManager {
    
    // MARK: Singleton
    static private var shared: LocalsManager = LocalsManager()
    
    // MARK: Declarations
    private var _languageDict: RootLanguages = [:]
    private var languagesDict: RootLanguages  {
        get {
            return _languageDict
        }
        set {
            _languageDict = newValue
            if !_languageDict.isEmpty {
                debugDictionary()
                UserDefaultsManager.save(value: _languageDict, for: .languagesDictionaries)
            }
        }
    }
    
    private var currentLanguageCode: String? = (UserDefaultsManager.getValue(for: .currentLanguageCode) as? String) ?? NSLocale.current.languageCode
    
    var localsDict: Translations {
        languagesDict[currentLanguageCode ?? ""] ?? [:]
    }
}


// MARK: - Public access methods
extension LocalsManager {

    public static func getLocalisable(for key: String) -> String {
        let dict = LocalsManager.shared.localsDict
        return dict[key] ?? key
    }
    
    public static func update(_ dict: RootLanguages) {
        LocalsManager.shared.languagesDict = dict
    }
    
    public static func setLanguage(_ lang: String) {
        LocalsManager.shared.currentLanguageCode = lang
        UserDefaultsManager.save(value: lang, for: .currentLanguageCode)
    }
}

// MARK: - Debug
extension LocalsManager {
    private func printAPIError(_ error: LocoApiError) {
        print(error.localizedDescription)
    }
    
    private func debugDictionary() {
        print("\(languagesDict.count) languages found:")
        languagesDict.keys.forEach { langKey in
            print("• '\(langKey)' -> ", terminator: "")
            print("\(languagesDict[langKey]?.values.count ?? 0) translations found.")
            
            languagesDict[langKey]?.keys.forEach { key in
                print("\t- '\(key)' = '\(languagesDict[langKey]?[key] ?? "")'")
            }
        }
        print("")
    }
}
