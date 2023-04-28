//
//  ListFilmsViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit


class ListFilmsViewController: UIViewController, ListFilmViewDelegate {
    
    var filmView = ListFilmView()
    var film: Result = Result(adult: false,
                              backdropPath: "",
                              genreIDS: [0],
                              id: 0,
                              originalLanguage: .en,
                              originalTitle: "",
                              overview: "",
                              popularity: 0.0,
                              posterPath: "",
                              releaseDate: "",
                              title: "",
                              video: false,
                              voteAverage: 0.0,
                              voteCount: 0)

    override func loadView() {
        super.loadView()
        view = filmView
        filmView.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToDetailViewController(filmSelected: Result) {
        let detailVC = DetailFilmViewController()// instancie a próxima UIViewController onde você quer enviar o filme
        detailVC.film = filmSelected // defina o objeto de filme na próxima UIViewController
        navigationController?.pushViewController(detailVC, animated: true) // navegue para a próxima UIViewController
    }
   
}
