//
//  FilmListPresenterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmListPresenterTests: XCTestCase {
    
    var sut: FilmListPresenter!
    var vcSpy: FilmListViewControllerSpy!
    
    override func setUp() {
        vcSpy = FilmListViewControllerSpy()
        sut = FilmListPresenter(viewController: vcSpy)
    }
    
    override func tearDown() {
        vcSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testConfigureList() {
        // Given
        let response = FilmListModel.FilmList.Response(list: ObjectSeeds.filmModelConvertedDate)
        
        // When
        sut.configureList(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayConfigureListCalled)
        XCTAssertEqual(vcSpy.viewModel.list, response.list)
    }
    
    func testFormatReleaseDate() {
        // Given
        let filmModel = ObjectSeeds.filmModel
        
        // When
        let result = sut.formatReleaseDate(films: filmModel)
        
        // Then
        let expectedReleaseDate = TestStrings.especificDate
        XCTAssertEqual(result.results.first?.releaseDate, expectedReleaseDate)
    }
}

class FilmListViewControllerSpy: UIViewController, FilmListDisplayLogic {
    var displayConfigureListCalled = false
    var viewModel = FilmListModel.FormattedFilmList.ViewModel(list: ObjectSeeds.filmModel)
    func displayConfigureList(_ viewModel: ListarFilmesVIP.FilmListModel.FormattedFilmList.ViewModel) {
        displayConfigureListCalled = true
        self.viewModel = viewModel
    }
}
