//
//  UsuarioModel.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import Foundation

class UsuarioModel {
    var login: String
    var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
