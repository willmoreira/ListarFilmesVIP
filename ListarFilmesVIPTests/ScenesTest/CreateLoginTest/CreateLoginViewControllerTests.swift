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
        sut.mainView.inputSenha.text = "password"
        sut.mainView.inputLogin.text = "email@example.com"
        
        sut.createButtonPressed()
        
        XCTAssertTrue(interactorMock.doCreateLoginCalled)
        XCTAssertEqual(interactorMock.request?.password, "password")
        XCTAssertEqual(interactorMock.request?.login, "email@example.com")
    }
    
    func testDisplayStartLoading_ShouldStartActivityIndicator() {
        let viewModel = CreateLoginModel.CreateLogin.ViewModel()
        
        sut.displayStartLoading(viewModel)
        
        XCTAssertTrue(mainViewMock.activityIndicatorStartAnimatingCalled)
    }
    
    func testDisplayStopLoading_ShouldStopActivityIndicator() {
        let viewModel = CreateLoginModel.CreateLogin.ViewModel()
        
        sut.displayStopLoading(viewModel)
        
        XCTAssertTrue(mainViewMock.activityIndicatorStopAnimatingCalled)
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
        var presentedAlertController: UIAlertController?
        
        override func startAnimating() {
            activityIndicatorStartAnimatingCalled = true
        }
        
        override func stopAnimating() {
            activityIndicatorStopAnimatingCalled = true
        }
        
        func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
            alertControllerPresentedCalled = true
            presentedAlertController = viewControllerToPresent as? UIAlertController
        }
    }
}

