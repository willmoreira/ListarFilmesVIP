//
//  ResetLoginViewController.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 09/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class ResetLoginViewControllerTests: XCTestCase {
    
    var sut: ResetLoginViewController!
    var dataSourceMock: ResetLoginModel.DataSource!
    var mainViewMock: ResetLoginViewMock!
    var interactorMock: ResetLoginInteractableMock!
    var routerMock: ResetLoginRoutingMock!
    
    override func setUp() {
        super.setUp()
        
        mainViewMock = ResetLoginViewMock()
        interactorMock = ResetLoginInteractableMock()
        routerMock = ResetLoginRoutingMock()
        dataSourceMock = ResetLoginModel.DataSource()
        sut = ResetLoginViewController(mainView: mainViewMock, dataSource: dataSourceMock)
        sut.interactor = interactorMock
        sut.router = routerMock
    }
    
    override func tearDown() {
        sut = nil
        mainViewMock = nil
        interactorMock = nil
        routerMock = nil
        super.tearDown()
    }
    
    func testDisplayStartLoading_ShouldStartActivityIndicator() {
        // Given
        let viewModel = ResetLoginModel.ResetLogin.Response()
        
        // When
        sut.displayStartLoading(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.activityIndicatorStartAnimatingCalled)
    }
    
    func testDisplayStopLoading_ShouldStopActivityIndicator() {
        // Given
        let viewModel = ResetLoginModel.ResetLogin.Response()
        
        // When
        sut.displayStopLoading(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.activityIndicatorStopAnimatingCalled)
    }
    
    func testCreateButtonPressed_ShouldCallInteractorWithRequest() {
        // Given
        mainViewMock.inputLogin.text = TestStrings.anyLogin
        
        // When
        sut.resetLoginButtonPressed()
        
        // Then
        XCTAssertTrue(interactorMock.doResetLoginCalled)
        XCTAssertEqual(interactorMock.request?.login, TestStrings.anyLogin)
    }
    
    func testViewDidLoad() {
        // Given
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.navigationItem.backBarButtonItem?.title, TestStrings.back)
        XCTAssertEqual(sut.mainView.backgroundColor, .white)
        XCTAssertTrue(sut.mainView.delegate === sut)
    }
    
    func testDisplayShowAlertCalled() {
        // Given
        let viewModel = ResetLoginModel.ResetLogin.ViewModel(titleMessage: TestStrings.alertTitle, message: TestStrings.alertMessage)
        
        // When
        sut.displayShowAlert(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.alertControllerPresentedCalled)
    }
}

class ResetLoginViewMock: ResetLoginView {
    var activityIndicatorStartAnimatingCalled = false
    var activityIndicatorStopAnimatingCalled = false
    var alertControllerPresentedCalled = false

    override func startAnimating() {
        activityIndicatorStartAnimatingCalled = true
    }
    
    override func stopAnimating() {
        activityIndicatorStopAnimatingCalled = true
    }
    
    override func showAlert(title: String, message: String, completion: (() -> Void)?) {
        alertControllerPresentedCalled = true
    }
}

class ResetLoginInteractableMock: ResetLoginInteractable {
    var dataSource: ResetLoginModel.DataSource {
        return ResetLoginModel.DataSource()
    }
    var doResetLoginCalled = false
    var request: ResetLoginModel.ResetLogin.Request?
    
    func doResetLogin(_ request: ResetLoginModel.ResetLogin.Request) {
        doResetLoginCalled = true
        self.request = request
    }
}

class ResetLoginRoutingMock: ResetLoginRouting {
    var popViewControllerCalled = false
    
    func popViewController(animated: Bool) {
        popViewControllerCalled = true
    }
}
