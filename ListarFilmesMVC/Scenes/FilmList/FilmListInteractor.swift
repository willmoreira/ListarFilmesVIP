//
//  FilmListInteractor.swift
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

typealias FilmListInteractable = FilmListBusinessLogic & FilmListDataStore

protocol FilmListBusinessLogic {
    func doRequest(_ request: FilmListModel.Request)
    func setupMainView(_ request: FilmListModel.FilmList.Request)
    func goToDetail(_ request: FilmListModel.FilmListResult.Request)
}

protocol FilmListDataStore {
    var dataSource: FilmListModel.DataSource { get }
}

final class FilmListInteractor: FilmListDataStore {
    
    var dataSource: FilmListModel.DataSource
    
    private var presenter: FilmListPresentationLogic
    
    init(viewController: FilmListDisplayLogic?, dataSource: FilmListModel.DataSource) {
        self.dataSource = dataSource
        self.presenter = FilmListPresenter(viewController: viewController)
    }
}


// MARK: - FilmListBusinessLogic
extension FilmListInteractor: FilmListBusinessLogic {
    func setupMainView(_ request: FilmListModel.FilmList.Request) {
        let response = FilmListModel.FilmList.Response(list: dataSource.filmModelList)
        presenter.setupMainView(response)
    }
    
    func goToDetail(_ request: FilmListModel.FilmListResult.Request) {
        let response = FilmListModel.FilmListResult.Response(result: request.result)
        presenter.goToDetailList(response)
    }
    
    func doRequest(_ request: FilmListModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            switch request {
                
            case .doSomething(let item):
                self.doSomething(item)
            }
        }
    }
}


// MARK: - Private Zone
private extension FilmListInteractor {
   
    
    func doSomething(_ item: Int) {
        
        //construct the Service right before using it
        //let serviceX = factory.makeXService()
        
        // get new data async or sync
        //let newData = serviceX.getNewData()
        
        presenter.presentResponse(.doSomething(newItem: item + 1, isItem: true))
    }
}
