//
//  UsuarioModel.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import Foundation


class UsuarioModel {
    var login: String
    var senha: String
    
    init(login: String, senha: String) {
        self.login = login
        self.senha = senha
    }
}
