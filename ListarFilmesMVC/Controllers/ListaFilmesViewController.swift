//
//  ListaFilmesViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit


class ListaFilmesViewController: UIViewController {
    

    var viewFilmes = FilmeView()
    
    override func loadView() {
        
        super.loadView()
        view = viewFilmes
        view.backgroundColor = .white
        
        
    }
    
    
    
}
