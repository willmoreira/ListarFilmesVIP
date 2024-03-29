//
//  FilmDetailInteractorTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmDetailInteractorTests: XCTestCase {

    var sut: FilmDetailInteractor!
    var dataSourceMock: FilmDetailModel.DataSource!
    var presenterMock: FilmDetailPresentationLogicMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = FilmDetailModel.DataSource(
            film: ObjectSeeds.result)
        presenterMock = FilmDetailPresentationLogicMock()
        sut = FilmDetailInteractor(
            viewController: nil,
            dataSource: dataSourceMock)
        sut.presenter = presenterMock
    }
    
    override func tearDown() {
        dataSourceMock = nil
        presenterMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testSetupMainView() {
        // Given
        let response = FilmDetailModel.FilmDetail.Request()
        
        // When
        sut.setupMainView(response)
        
        // Then
        XCTAssertTrue(presenterMock.presentSetupMainViewCalled)
    }
}

class FilmDetailPresentationLogicMock: FilmDetailPresentationLogic {
    var presentSetupMainViewCalled = false
    var presentSetupMainViewResponse: FilmDetailModel.FilmDetail.Response?
    
    func presentSetupMainView(_ response: FilmDetailModel.FilmDetail.Response) {
        presentSetupMainViewCalled = true
        presentSetupMainViewResponse = response
    }
}
