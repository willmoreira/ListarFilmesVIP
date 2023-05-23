//
//  FilmListRouterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 22/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmListRouterTests: XCTestCase {
    
    var viewControllerMock: UIViewController!
    var sut: FilmListRouter!
    var dataSourceMock: FilmListDataStore!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = UIViewController()
        sut = FilmListRouter(viewController: viewControllerMock)
    }
    
    override func tearDown() {
        viewControllerMock = nil
        sut = nil
        
        super.tearDown()
    }
}

class NavigationMock: UINavigationController {
    var pushViewControllerCalled = false
    var pushedViewController: UIViewController?
    var pushedCompletion: (() -> Void)?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushedViewController = viewController
        pushedCompletion?()
    }
}

class FilmListDataStoreMock: FilmListDataStore {
    var dataSource: FilmListModel.DataSource = FilmListModel.DataSource(filmModelList: FilmModel(
        page: 0,
        results: [Result(
            adult: false,
            backdropPath: "teste",
            genreIDS: [0],
            id: 0,
            originalLanguage: "en",
            originalTitle: "teste",
            overview: "teste",
            popularity: 0.0,
            posterPath: "teste",
            releaseDate: "01 de outubro de 2023",
            title: "teste",
            video: false,
            voteAverage: 0.0,
            voteCount: 0)],
        totalPages: 1,
        totalResults: 1))
}
