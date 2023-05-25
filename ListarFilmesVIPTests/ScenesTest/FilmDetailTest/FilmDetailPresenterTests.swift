//
//  FilmDetailPresenterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmDetailPresenterTests: XCTestCase {
    
    var sut: FilmDetailPresenter!
    var vcSpy: FilmDetailViewControllerSpy!
    
    override func setUp() {
        vcSpy = FilmDetailViewControllerSpy()
        sut = FilmDetailPresenter(viewController: vcSpy)
    }
    
    override func tearDown() {
        vcSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testPresentSetupMainView() {
        // Given
        let film = ObjectSeeds.result
        let response = FilmDetailModel.FilmDetail.Response(film: film)
        
        // When
        sut.presentSetupMainView(response)
        
        // Then
        XCTAssertTrue(vcSpy.displaySetupMainViewCalled)
        XCTAssertEqual(vcSpy.viewModel?.film, response.film)
    }
}

class FilmDetailViewControllerSpy: UIViewController, FilmDetailDisplayLogic {
    
    var displaySetupMainViewCalled = false
    var viewModel: FilmDetailModel.FilmDetail.ViewModel?
    
    func displaySetupMainView(_ viewModel: ListarFilmesVIP.FilmDetailModel.FilmDetail.ViewModel) {
        displaySetupMainViewCalled = true
        self.viewModel = viewModel
    }
}
