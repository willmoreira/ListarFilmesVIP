//
//  LoginPresenterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class LoginPresenterTests: XCTestCase {
    
    var sut: LoginPresenter!
    var vcSpy: LoginViewControllerSpy!
    
    override func setUp() {
        vcSpy = LoginViewControllerSpy()
        sut = LoginPresenter(viewController: vcSpy)
    }
    
    override func tearDown() {
        vcSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testPresentStartLoading() {
        // Given
        let response = LoginModel.Login.Response()
        
        // When
        sut.presentStartLoading(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayStartLoadingCalled)
    }
    
    func testPresentStopLoading() {
        // Given
        let response = LoginModel.Login.Response()
        
        // When
        sut.presentStopLoading(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayStopLoadingCalled)
    }
    
    func testPresentShowAlert() {
        // Given
        let response = LoginModel.Login.Response(titleMessage: "Title",   message: "Message")
        
        // When
        sut.presentShowAlert(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayShowAlertCalled)
        XCTAssertEqual(vcSpy.viewModel?.titleMessage, response.titleMessage)
        XCTAssertEqual(vcSpy.viewModel?.message, response.message)
    }
    
    func testPresentCleanFields() {
        // Given
        let response = LoginModel.Login.Response()
        
        // When
        sut.presentCleanFields(response)
        
        // When
        XCTAssertTrue(vcSpy.displayCleanFieldsCalled)
    }
    
    func testPresentGoToListFilms() {
        // Given
        let response = LoginModel.Login.Response()
        
        // When
        sut.presentGoToListFilms(response)
        
        // When
        XCTAssertTrue(vcSpy.displayGoToFilmListCalled)
    }
    
}

class LoginViewControllerSpy: UIViewController, LoginDisplayLogic {
    
    var displayShowAlertCalled = false
    var displayGoToFilmListCalled = false
    var displayStartLoadingCalled = false
    var displayStopLoadingCalled = false
    var displayCleanFieldsCalled = false
    var viewModel: LoginModel.Login.ViewModel?
    
    func displayShowAlert(_ viewModel: ListarFilmesVIP.LoginModel.Login.ViewModel) {
        self.viewModel = viewModel
        displayShowAlertCalled = true
    }
    
    func displayGoToFilmList(_ viewModel: ListarFilmesVIP.LoginModel.Login.ViewModel) {
        displayGoToFilmListCalled = true
    }
    
    func displayStartLoading(_ viewModel: ListarFilmesVIP.LoginModel.Login.ViewModel) {
        displayStartLoadingCalled = true
    }
    
    func displayStopLoading(_ viewModel: ListarFilmesVIP.LoginModel.Login.ViewModel) {
        displayStopLoadingCalled = true
    }
    
    func displayCleanFields(_ viewModel: ListarFilmesVIP.LoginModel.Login.ViewModel) {
        displayCleanFieldsCalled = true
    }
}
