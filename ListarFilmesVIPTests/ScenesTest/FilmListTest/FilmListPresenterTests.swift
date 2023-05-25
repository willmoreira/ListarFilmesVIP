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
        let response = FilmListModel.FilmList.Response(
            list: FilmModel(
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
        
        // When
        sut.configureList(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayConfigureListCalled)
        XCTAssertEqual(vcSpy.viewModel.list, response.list)
    }
    
    func testFormatReleaseDate() {
        // Given
        let filmModel = FilmModel(
            page: 1,
            results: [ObjectSeeds.result],
            totalPages: 1,
            totalResults: 1)
        
        // When
        let result = sut.formatReleaseDate(films: filmModel)
        
        // Then
        let expectedReleaseDate = "11 de maio de 2021"
        XCTAssertEqual(result.results.first?.releaseDate, expectedReleaseDate)
    }
}


class FilmListViewControllerSpy: UIViewController, FilmListDisplayLogic {
    
    var displayConfigureListCalled = false
    var viewModel = FilmListModel.FormattedFilmList.ViewModel(list: FilmModel(
        page: 0,
        results: [ObjectSeeds.result],
        totalPages: 1,
        totalResults: 1))
    
    func displayConfigureList(_ viewModel: ListarFilmesVIP.FilmListModel.FormattedFilmList.ViewModel) {
        displayConfigureListCalled = true
        self.viewModel = viewModel
    }
}
