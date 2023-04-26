//
//  FilmeModel.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import Foundation

class FilmeModel {
    var id: Int
    var nome: String
    var descricao: String
    var imagem: String
    
    init(id: Int, nome: String, descricao: String, imagem: String) {
        self.id = id
        self.nome = nome
        self.descricao = descricao
        self.imagem = imagem
    }
}
