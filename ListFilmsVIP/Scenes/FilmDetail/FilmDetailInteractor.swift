//
//  FilmDetailInteractor.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

typealias FilmDetailInteractable = FilmDetailBusinessLogic & FilmDetailDataStore

protocol FilmDetailBusinessLogic {
    func setupMainView(_ request: FilmDetailModel.FilmDetail.Request)
}

protocol FilmDetailDataStore {
    var dataSource: FilmDetailModel.DataSource { get }
}

final class FilmDetailInteractor: FilmDetailDataStore {
    var dataSource: FilmDetailModel.DataSource
    
    var presenter: FilmDetailPresentationLogic
    
    init(viewController: FilmDetailDisplayLogic?, dataSource: FilmDetailModel.DataSource) {
        self.dataSource = dataSource
        self.presenter = FilmDetailPresenter(viewController: viewController)
    }
}

// MARK: - FilmDetailBusinessLogic
extension FilmDetailInteractor: FilmDetailBusinessLogic {
    func setupMainView(_ request: FilmDetailModel.FilmDetail.Request) {
        let film = dataSource.film
        let response = FilmDetailModel.FilmDetail.Response(film: film)
        presenter.presentSetupMainView(response)
    }
}

// MARK: - Private Zone
private extension FilmDetailInteractor {
    
}
