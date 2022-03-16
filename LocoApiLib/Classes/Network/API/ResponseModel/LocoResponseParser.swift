//
//  Parser.swift
//  Loco API Test
//
//  Created by Morgan Berger on 09/03/2022.
//

import Foundation

struct LocoResponseParser {
    
    /// Create the main dictionary containing all the localizables for each found language.
    /// - Parameter response: The LocoResponse.*value* object return by the API
    /// - Returns:The fullfilled dictionary
    public static func parse(_ response: NSDictionary) -> [String : [String: String]] {
        var rootLangDict: [String: [String: String]] = [:]
        response.allKeys.forEach { key in
            if let key = key as? String,
               let localsDict = response[key] as? [String: String] {
                rootLangDict[key] = localsDict
            }
        }
        return rootLangDict
    }
}
