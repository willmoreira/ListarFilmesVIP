//
//  CreateLoginViewControllerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class CreateLoginViewControllerTests: XCTestCase {
    
    var sut: CreateLoginViewController!
    var dataSourceMock: CreateLoginModel.DataSource!
    var mainViewMock: CreateLoginViewMock!
    var interactorMock: CreateLoginInteractableMock!
    var routerMock: CreateLoginRoutingMock!
    
    override func setUp() {
        super.setUp()
        
        mainViewMock = CreateLoginViewMock()
        interactorMock = CreateLoginInteractableMock()
        routerMock = CreateLoginRoutingMock()
        dataSourceMock = CreateLoginModel.DataSource()
        
        sut = CreateLoginViewController(mainView: mainViewMock, dataSource: dataSourceMock)
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
    
    func testViewDidLoad_ShouldSetDelegateAndBackgroundColor() {
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.mainView.delegate as? CreateLoginViewController, sut)
        XCTAssertEqual(sut.mainView.backgroundColor, .white)
    }
    
    func testCreateButtonPressed_ShouldCallInteractorWithRequest() {
        // Given
        mainViewMock.inputSenha.text = TestStrings.anyPassword
        mainViewMock.inputLogin.text = TestStrings.anyLogin
        
        // When
        sut.createButtonPressed()
        
        // Then
        XCTAssertTrue(interactorMock.doCreateLoginCalled)
        XCTAssertEqual(interactorMock.request?.password, TestStrings.anyPassword)
        XCTAssertEqual(interactorMock.request?.login, TestStrings.anyLogin)
    }
    
    func testDisplayStartLoading_ShouldStartActivityIndicator() {
        // Given
        let viewModel = CreateLoginModel.CreateLogin.ViewModel()
        
        // When
        sut.displayStartLoading(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.activityIndicatorStartAnimatingCalled)
    }
    
    func testDisplayStopLoading_ShouldStopActivityIndicator() {
        // Given
        let viewModel = CreateLoginModel.CreateLogin.ViewModel()
        
        // When
        sut.displayStopLoading(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.activityIndicatorStopAnimatingCalled)
    }
    
    
    func testDisplayShowAlertCalled() {
        // Given
        let viewModel = CreateLoginModel.CreateLogin.ViewModel(titleMessage: TestStrings.alertTitle, message: TestStrings.alertMessage)
        
        // When
        sut.displayShowAlert(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.alertControllerPresentedCalled)
    }
    
    class CreateLoginInteractableMock: CreateLoginInteractable {
        var dataSource: CreateLoginModel.DataSource {
            return CreateLoginModel.DataSource()
        }
        
        var doCreateLoginCalled = false
        var request: CreateLoginModel.CreateLogin.Request?
        
        func doCreateLogin(_ request: CreateLoginModel.CreateLogin.Request) {
            doCreateLoginCalled = true
            self.request = request
        }
    }
    
    class CreateLoginRoutingMock: CreateLoginRouting {
        var popViewControllerCalled = false
        
        func popViewController(animated: Bool) {
            popViewControllerCalled = true
        }
    }
    
    class CreateLoginViewMock: CreateLoginView {
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
    
}

