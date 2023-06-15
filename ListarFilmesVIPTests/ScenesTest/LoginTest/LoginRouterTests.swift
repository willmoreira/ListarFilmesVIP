//
//  LoginRouterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 22/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class LoginRouterTests: XCTestCase {
    
    var viewControllerMock: UIViewController!
    var sut: LoginRouter!
    var dataSourceMock: LoginDataStore!
    var navigationMock: NavigationMock!
    
    override func setUp() {
        super.setUp()
        viewControllerMock = UIViewController()
        navigationMock = NavigationMock()
        navigationMock.viewControllers = [viewControllerMock]
        dataSourceMock = LoginDataStoreMock()
        sut = LoginRouter(viewController: viewControllerMock)
        sut.dataStore = dataSourceMock
    }
    
    override func tearDown() {
        viewControllerMock = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testRouteToCreateLoginViewControllerCalled() {
        
        // Given
        let route = LoginModel.Login.Route()
        let expection = expectation(description: "push CreateLoginViewController called")
        var validateController: UIViewController?
        
        navigationMock.pushViewControllerCompletion = { viewController, animated in
            validateController = viewController
            expection.fulfill()
        }
        
        // When
        sut.routeToCreateLogin(route)
        
        // Then
        waitForExpectations(timeout: 3.0)

        //wait(for: [expection], timeout: 3.0)
        guard let safeValidateController = validateController else { return XCTFail() }
        XCTAssertTrue(safeValidateController is CreateLoginViewController)
    }
    
    func testRouteToResetLoginViewControllerCalled() {
        
        // Given
        let route = LoginModel.Login.Route()
        let expection = expectation(description: "push ResetLoginViewController called")
        var validateController: UIViewController?
        
        navigationMock.pushViewControllerCompletion = { viewController, animated in
            validateController = viewController
            expection.fulfill()
        }
        
        // When
        sut.routeToResetLogin(route)
        
        // Then
        waitForExpectations(timeout: 3.0)

        //wait(for: [expection], timeout: 3.0)
        guard let safeValidateController = validateController else { return XCTFail() }
        XCTAssertTrue(safeValidateController is ResetLoginViewController)
    }
    
    func testRouteToFilmListViewControllerCalled() {
        
        // Given
        let route = LoginModel.Login.Route()
        let expection = expectation(description: "push FilmListViewController called")
        var validateController: UIViewController?
        
        navigationMock.pushViewControllerCompletion = { viewController, animated in
            validateController = viewController
            expection.fulfill()
        }
        
        // When
        sut.routeToListfilms(route)
        
        // Then
        waitForExpectations(timeout: 3.0)

        //wait(for: [expection], timeout: 3.0)
        guard let safeValidateController = validateController else { return XCTFail() }
        XCTAssertTrue(safeValidateController is FilmListViewController)
    }
}

class LoginDataStoreMock: LoginDataStore {
    var dataSource: LoginModel.DataSource = LoginModel.DataSource(filmModelList: ObjectSeeds.filmModel)
}
