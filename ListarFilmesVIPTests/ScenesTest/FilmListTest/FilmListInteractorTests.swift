//
//  FilmListInteractorTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class FilmListInteractorTests: XCTestCase {
    
    var sut: FilmListInteractor!
    var dataSourceMock: FilmListModel.DataSource!
    var presenterMock: FilmListPresentationLogicMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = FilmListModel.DataSource(
            filmModelList: FilmModel(
                page: 0,
                results: [ObjectSeeds.result],
                totalPages: 0,
                totalResults: 0)
        )
        presenterMock = FilmListPresentationLogicMock()
        sut = FilmListInteractor(
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
    
    func testConfigureList() {
        // Given
        let request = FilmListModel.FilmList.Request()
        
        // When
        sut.configureList(request)
        
        // Then
        XCTAssertTrue(presenterMock.presentConfigureListCalled)
    }
}

class FilmListPresentationLogicMock: FilmListPresentationLogic {
    var presentConfigureListCalled = false
    var presentConfigureListResponse = FilmListModel.FilmList.Response(
        list: FilmModel(
            page: 0,
            results: [ObjectSeeds.result],
            totalPages: 0,
            totalResults: 0)
    )
    
    func configureList(_ response: FilmListModel.FilmList.Response) {
        presentConfigureListCalled = true
        presentConfigureListResponse = response
    }
}
