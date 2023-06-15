//
//  FilmListViewController.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates(https://github.com/Andrei-Popilian/VIP_Design_Xcode_Template)
//  so you can apply clean architecture to your iOS and MacOS projects,
//  see more http://clean-swift.com
//

import UIKit

protocol FilmListDisplayLogic where Self: UIViewController {
    func displayConfigureList(_ viewModel: FilmListModel.FormattedFilmList.ViewModel)
}

class FilmListViewController: BaseUIViewController {
    var mainView: FilmListView
    var interactor: FilmListInteractable!
    var router: (FilmListRouting & FilmListDataPassing)!
    
    init(mainView: FilmListView, dataSource: FilmListModel.DataSource) {
        self.mainView = mainView
        self.mainView.listFilms = dataSource.filmModelList.results
        super.init(nibName: nil, bundle: nil)
        interactor = FilmListInteractor(viewController: self, dataSource: dataSource)
        router = FilmListRouter(viewController: self)
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        mainView.delegate = self

        let request = FilmListModel.FilmList.Request()
        interactor.configureList(request)
    }
    
    override func loadView() {
        view = mainView
    }
}

// MARK: - FilmListDisplayLogic
extension FilmListViewController: FilmListDisplayLogic {
    func displayConfigureList(_ viewModel: FilmListModel.FormattedFilmList.ViewModel) {
        if let view = self.view as? FilmListView {
            view.listFilms = viewModel.list.results
        }
    }
}

// MARK: - FilmListViewDelegate
extension FilmListViewController: FilmListViewDelegate {
    func goToDetailViewController(_ index: Int) {
        router.routeToFilmDetail(index)
    }
}
