//
//  ListFilmesViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit


class ListFilmesViewController: UIViewController {
    
    var viewFilmes = FilmeView()
    
    override func loadView() {
        
        super.loadView()
        view = viewFilmes
        print(viewFilmes.listFilmes)
        view.backgroundColor = .white
        
    }
}
