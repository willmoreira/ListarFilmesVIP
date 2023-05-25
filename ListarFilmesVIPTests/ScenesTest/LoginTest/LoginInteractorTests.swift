//
//  LoginInteractorTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP
import FirebaseAuth

final class LoginInteractorTests: XCTestCase {
    
    var sut: LoginInteractor!
    var dataSourceMock: LoginModel.DataSource!
    var presenterMock: LoginPresentationLogicMock!
    var loginWorkerMock: LoginWorkerMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = LoginModel.DataSource(
            filmModelList: FilmModel(
                page: 0,
                results: [ObjectSeeds.result],
                totalPages: 0,
                totalResults: 0))
        presenterMock = LoginPresentationLogicMock()
        loginWorkerMock = LoginWorkerMock()
        sut = LoginInteractor(viewController: nil,
                              dataSource: dataSourceMock,
                              loginWorker: loginWorkerMock)
        sut.presenter = presenterMock
    }
    
    override func tearDown() {
        presenterMock = nil
        dataSourceMock = nil
        loginWorkerMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testTryLoginSucess() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.anyLogin)
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, nil)
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
    }
    
    func testTryLoginErrorWrongEmailFormat() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.incorretEmail)
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17008, userInfo:nil))
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.incorrectEmailFormat)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.incorrectEmailFormatMessage)
    }
    
    func testTryLoginUserNotFound() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.newEmail)
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17011, userInfo:nil))
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.userNotFound)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.userNotFoundMessage)
    }
    
    func testTryLoginWrongPassword() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.existingRealEmail)
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17009, userInfo:nil))
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.invalidPassword)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.invalidPasswordMessage)
    }
    
    func testDoLoginFieldPasswordEmpty() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.stringEmpty, login: TestStrings.anyLogin)
        
        // When
        sut.doLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.errorInPasswordField)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.errorInPasswordFieldMessage)
    }
    
    func testDoLoginFieldLoginEmpty() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.stringEmpty)
        
        // When
        sut.doLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.errorInLoginField)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.errorInLoginFieldMessage)
    }
    
    func testDoLoginSuccess() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.anyLogin)
        
        // When
        sut.doLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
    }
    
    func testCleanTextFields() {
        // Given
        let request = LoginModel.Login.Request(password: TestStrings.anyPassword, login: TestStrings.anyLogin)
        
        // When
        sut.cleanFields(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentCleanFieldsCalled)
    }
    
    func testSearchFilmList() {
        // Given
        let expectation = XCTestExpectation(description: "Receber resposta da API")
        let apiKey = TestStrings.apiKey
        let urlString = TestStrings.urlString + apiKey
        
     
        // When
        sut.searchFilmList(apiKey: apiKey, urlString: urlString)
                
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.sut.dataSource.filmModelList, TestStrings.listOfMoviesMustNotBeNull)
            XCTAssertFalse(self.sut.dataSource.filmModelList.results.isEmpty, TestStrings.movieListMustNotBeEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

class LoginPresentationLogicMock: LoginPresentationLogic {
    
    var presentGoToListFilmCalled = false
    var presentCleanFieldsCalled = false
    var presentStartLoadingCalled = false
    var presentStopLoadingCalled = false
    var presentShowAlertCalled = false
    var presentShowAlertResponse: LoginModel.Login.Response?
    var presentCleanFieldsResponse: LoginModel.Login.Response?
    
    func presentShowAlert(_ response: ListarFilmesVIP.LoginModel.Login.Response) {
        presentShowAlertCalled = true
        presentShowAlertResponse = response
    }
    
    func presentStartLoading(_ response: ListarFilmesVIP.LoginModel.Login.Response) {
        presentStartLoadingCalled = true
    }
    
    func presentStopLoading(_ response: ListarFilmesVIP.LoginModel.Login.Response) {
        presentStopLoadingCalled = true
    }
    
    func presentGoToListFilms(_ response: ListarFilmesVIP.LoginModel.Login.Response) {
        presentGoToListFilmCalled = true
    }
    
    func presentCleanFields(_ response: ListarFilmesVIP.LoginModel.Login.Response) {
        presentCleanFieldsCalled = true
        presentCleanFieldsResponse = response
    }
}
