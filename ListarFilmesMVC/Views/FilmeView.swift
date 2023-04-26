//
//  FilmeView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit

class FilmeView: UIView {
    
    var listFilmes: [FilmeModel] = []
    var titleTela = UILabel()
    var buttonSair = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInit()
    }
    
    private func setupInit() {
        self.titleTela.text = "Lista de Filmes"
        self.buttonSair.titleLabel?.text = "Sair"
    }
}
