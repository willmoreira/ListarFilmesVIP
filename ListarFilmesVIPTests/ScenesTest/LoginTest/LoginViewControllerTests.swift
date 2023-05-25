//
//  LoginViewControllerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class LoginViewControllerTests: XCTestCase {
    var sut: LoginViewController!
    var mainViewMock: LoginViewMock!
    var interactorMock: LoginInteractableMock!
    var routerMock: RouterMock!
    var dataSourceMock: LoginModel.DataSource!
    
    override func setUp() {
        super.setUp()
        mainViewMock = LoginViewMock()
        dataSourceMock = LoginModel.DataSource(
            filmModelList: FilmModel(
                page: 0,
                results: [ObjectSeeds.result],
                totalPages: 0,
                totalResults: 0))
        interactorMock = LoginInteractableMock(dataSource: dataSourceMock)
        routerMock = RouterMock()
        sut = LoginViewController(mainView: mainViewMock, dataSource: dataSourceMock)
        sut.interactor = interactorMock
        sut.mainView = mainViewMock
        sut.router = routerMock
    }
    
    override func tearDown() {
        sut = nil
        mainViewMock = nil
        interactorMock = nil
        dataSourceMock = nil
        routerMock = nil
        super.tearDown()
    }
    
    func testViewDidLoad_ShouldSetDelegateAndBackgroundColor() {
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.mainView.delegate as? LoginViewController, sut)
        XCTAssertEqual(sut.mainView.backgroundColor, .white)
    }
    
    func testDisplayStartLoading_ShouldStartActivityIndicator() {
        // Given
        let viewModel = LoginModel.Login.ViewModel()
        
        // When
        sut.displayStartLoading(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.activityIndicatorStartAnimatingCalled)
    }
    
    func testDisplayStopLoading_ShouldStopActivityIndicator() {
        // Given
        let viewModel = LoginModel.Login.ViewModel()
        
        // When
        sut.displayStopLoading(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.activityIndicatorStopAnimatingCalled)
    }
    
    func testDisplayShowAlertCalled() {
        // Given
        let viewModel = LoginModel.Login.ViewModel(titleMessage: TestStrings.alertTitle, message: TestStrings.alertMessage)
        
        // When
        sut.displayShowAlert(viewModel)
        
        // Then
        XCTAssertTrue(mainViewMock.alertControllerPresentedCalled)
    }
    
    func testDisplayCleanFieldsClearsFields() {
        // Given
        mainViewMock.inputLogin.text = TestStrings.anyLogin
        mainViewMock.inputSenha.text = TestStrings.anyPassword
        
        let expectation = XCTestExpectation(description: "Fields cleared")
        
        // When
        sut.displayCleanFields(LoginModel.Login.ViewModel())
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.mainViewMock.inputLogin.text, TestStrings.stringEmpty)
            XCTAssertEqual(self.mainViewMock.inputSenha.text, TestStrings.stringEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDisplayGoToFilmListCallsRoutesToListFilms() {
        
        // Given
        let request = LoginModel.Login.Request()
        
        // When
        sut.displayGoToFilmList(LoginModel.Login.ViewModel())
        
        // Then
        XCTAssertTrue(routerMock.routeToListfilmsCalled)
    }
    
    func testResetButtonPressedRoutesToResetLogin() {
        // Given
        
        // When
        sut.resetButtonPressed()
        
        // Then
        XCTAssertTrue(routerMock.routeToResetLoginCalled)
    }
    
    func testCreateButtonPressedRoutesToCreateLogin() {
        // Given
        
        // When
        sut.createButtonPressed()
        
        // Then
        XCTAssertTrue(routerMock.routeToCreateLoginCalled)
    }
    
    func testLoginButtonPressedRoutesToCreateLogin() {
        // Given
        
        // When
        sut.loginButtonPressed()
        
        // Then
        XCTAssertTrue(interactorMock.doLoginCalled)
    }
}

class RouterMock: LoginRouting & LoginDataPassing {
    
    var dataStore: LoginDataStore?
    
    var routeToCreateLoginCalled = false
    var routeToResetLoginCalled = false
    var routeToListfilmsCalled = false
    var route: LoginModel.Login.Route?
    
    func routeToCreateLogin(_ route: LoginModel.Login.Route) {
        self.route = route
        routeToCreateLoginCalled = true
    }
    
    func routeToResetLogin(_ route: LoginModel.Login.Route) {
        self.route = route
        routeToResetLoginCalled = true
    }
    
    func routeToListfilms(_ route: LoginModel.Login.Route) {
        self.route = route
        routeToListfilmsCalled = true
    }
}

class LoginViewMock: LoginView {
    var activityIndicatorStartAnimatingCalled = false
    var activityIndicatorStopAnimatingCalled = false
    var alertControllerPresentedCalled = false
    
    override func startAnimating() {
        activityIndicatorStartAnimatingCalled = true
    }
    
    override func stopAnimating() {
        activityIndicatorStopAnimatingCalled = true
    }
    
    override func showAlert(title: String, message: String) {
        alertControllerPresentedCalled = true
    }
}

class LoginInteractableMock: LoginInteractable {
    
    var dataSource: LoginModel.DataSource
    var doLoginCalled = false
    var cleanFildsCalled = false
    
    init(dataSource: LoginModel.DataSource) {
        self.dataSource = dataSource
    }
    
    func doLogin(_ request: LoginModel.Login.Request) {
        doLoginCalled = true
    }
    
    func cleanFields(_ request: LoginModel.Login.Request) {
        cleanFildsCalled = true
    }
}
