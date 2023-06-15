//
//  FilmDetailViewControllerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmDetailViewControllerTests: XCTestCase {
    
    var sut: FilmDetailViewController!
    var mainViewMock: FilmDetailViewMock!
    var interactorMock: FilmDetailInteractableMock!
    var dataSourceMock: FilmDetailModel.DataSource!
    
    override func setUp() {
        super.setUp()
        mainViewMock = FilmDetailViewMock()
        interactorMock = FilmDetailInteractableMock()
        dataSourceMock = FilmDetailModel.DataSource(film: ObjectSeeds.result)
        sut = FilmDetailViewController(mainView: mainViewMock, dataSource: dataSourceMock)
        sut.interactor = interactorMock
        sut.mainView = mainViewMock
    }
    
    override func tearDown() {
        sut = nil
        mainViewMock = nil
        interactorMock = nil
        dataSourceMock = nil
        super.tearDown()
    }
    
    func testViewDidLoadSetupMainView() {
        // Given
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactorMock.setupMainViewCalled)
        
    }
    
    func testDisplaySetupMainView() {
        // Given
        let viewModel = FilmDetailModel.FilmDetail.ViewModel(
            film: ObjectSeeds.result)
        
        // When
        sut.displaySetupMainView(viewModel)
        
        // Then
        XCTAssertEqual(mainViewMock.film, viewModel.film)
        XCTAssertTrue(mainViewMock.updateFilmCalled)
        XCTAssertTrue(interactorMock.setupMainViewCalled)
    }
}

// Mock para FilmDetailView
class FilmDetailViewMock: FilmDetailView {
    var updateFilmCalled = false
    
    override func updateFilm() {
        updateFilmCalled = true
    }
}

// Mock para FilmDetailInteractable
class FilmDetailInteractableMock: FilmDetailInteractable {
    
    var setupMainViewCalled = false
    
    func setupMainView(_ request: FilmDetailModel.FilmDetail.Request) {
        setupMainViewCalled = true
    }
    
    var dataSource:FilmDetailModel.DataSource {
        return FilmDetailModel.DataSource(
            film: ObjectSeeds.result)
    }
}
