//
//  FilmListViewControllerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmListViewControllerTests: XCTestCase {
    
    var sut: FilmListViewController!
    var mainViewMock: FilmListViewMock!
    var interactorMock: FilmListInteractableMock!
    var dataSourceMock: FilmListModel.DataSource!
    var routerMock: FilmListRouterMock!
    
    override func setUp() {
        super.setUp()
        mainViewMock = FilmListViewMock()
        routerMock = FilmListRouterMock()
        dataSourceMock = FilmListModel.DataSource(
            filmModelList: FilmModel(
                page: 0,
                results: [Result(
                    adult: false,
                    backdropPath: "",
                    genreIDS: [0],
                    id: 0,
                    originalLanguage: "en",
                    originalTitle: "",
                    overview: "",
                    popularity: 0.0,
                    posterPath: "",
                    releaseDate: "",
                    title: "",
                    video: false,
                    voteAverage: 0.0,
                    voteCount: 0)],
                totalPages: 0,
                totalResults: 0))
        interactorMock = FilmListInteractableMock(dataSource: dataSourceMock)
        sut = FilmListViewController(mainView: mainViewMock, dataSource: dataSourceMock)
        sut.interactor = interactorMock
        sut.mainView = mainViewMock
        sut.router = routerMock
    }
    
    override func tearDown() {
        sut = nil
        mainViewMock = nil
        interactorMock = nil
        dataSourceMock = nil
        routerMock = nil
        super.tearDown()
    }
    
    func testViewDidLoad_ShouldSetDelegateAndBackgroundColor() {
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.mainView.delegate as? FilmListViewController, sut)
        XCTAssertEqual(sut.mainView.backgroundColor, .white)
    }
    
    func testDisplayConfigureList() {
        //Given
        let viewModel = FilmListModel.FormattedFilmList.ViewModel(
            list: FilmModel(
                page: 0,
                results: [Result(adult: false,
                                 backdropPath: "",
                                 genreIDS: [0],
                                 id: 0,
                                 originalLanguage: "",
                                 originalTitle: "",
                                 overview: "",
                                 popularity: 0.0,
                                 posterPath: "",
                                 releaseDate: "",
                                 title: "",
                                 video: false,
                                 voteAverage: 0.0,
                                 voteCount: 0)],
                totalPages: 0,
                totalResults: 0))
        
        //When
        sut.displayConfigureList(viewModel)
        
        //Then
        XCTAssertFalse(sut.mainView.listFilms.isEmpty)
    }
    
    
    func testCallRouterToFilmDetail() {
        //Given
        let index = 0
        
        //When
        sut.goToDetailViewController(index)
        
        //Then
        XCTAssertTrue(routerMock.routeToFilmDetailCalled)
        XCTAssertEqual(routerMock.routeToFilmDetailIndex, index)
    }
}

class FilmListViewMock: FilmListView {
    
}

class FilmListRouterMock: FilmListRouting & FilmListDataPassing {
    var dataStore: FilmListDataStore?
    
    var routeToFilmDetailCalled = false
    var routeToFilmDetailIndex: Int?
    
    func routeToFilmDetail(_ index: Int) {
        routeToFilmDetailCalled = true
        routeToFilmDetailIndex = index
    }
}

class FilmListInteractableMock: FilmListInteractable {
    var dataSource: FilmListModel.DataSource
    
    init(dataSource: FilmListModel.DataSource) {
        self.dataSource = dataSource
    }
    
    func configureList(_ request: FilmListModel.FilmList.Request) {
        
    }
}
