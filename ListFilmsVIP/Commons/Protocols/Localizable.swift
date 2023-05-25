//
//  Localizable.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 25/05/23.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}
