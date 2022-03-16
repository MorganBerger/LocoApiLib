//
//  String.swift
//  Loco API Test
//
//  Created by Morgan Berger on 14/03/2022.
//

import Foundation

extension String {
    var localized: String {
        return LocalsManager.getLocalisable(for: self)
    }
}
