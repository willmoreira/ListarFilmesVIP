//
//  ListFilmsViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit


class ListFilmsViewController: UIViewController {
    
    var filmView = FilmView()
    
    override func loadView() {
        super.loadView()
        view = filmView
        view.backgroundColor = .white
    }
}
