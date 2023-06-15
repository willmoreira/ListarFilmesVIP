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
    var navigationMock: NavigationMock!
    
    override func setUp() {
        super.setUp()
        viewControllerMock = UIViewController()
        navigationMock = NavigationMock()
        navigationMock.viewControllers = [viewControllerMock]
        dataSourceMock = FilmListDataStoreMock()
        sut = FilmListRouter(viewController: viewControllerMock)
        sut.dataStore = dataSourceMock
    }
    
    override func tearDown() {
        viewControllerMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testRouterFilmDetailViewControllerCalled() {
        
        // Given
        let index = 0
        let expection = expectation(description: "push filmDetailViewController called")
        var validateController: UIViewController?
        
        navigationMock.pushViewControllerCompletion = { viewController, animated in
            validateController = viewController
            expection.fulfill()
        }
        
        // When
        sut.routeToFilmDetail(index)
        
        // Then
        waitForExpectations(timeout: 3.0)

        //wait(for: [expection], timeout: 3.0)
        guard let safeValidateController = validateController else { return XCTFail()}
        XCTAssertTrue(safeValidateController is FilmDetailViewController)
    }
}

class NavigationMock: UINavigationController {
    var pushViewControllerCalled = false
    var pushViewControllerCompletion: ((UIViewController, Bool) -> Void)?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushViewControllerCompletion?(viewController, animated)
    }
}

class FilmListDataStoreMock: FilmListDataStore {
    var dataSource: FilmListModel.DataSource = FilmListModel.DataSource(filmModelList: ObjectSeeds.filmModel)
}
