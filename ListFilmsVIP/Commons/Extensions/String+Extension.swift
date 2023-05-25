//
//  String+Extension.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 25/05/23.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String{
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
