//
//  CreateLoginInteractorTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//
import XCTest
@testable import ListarFilmesVIP
import FirebaseAuth


class CreateLoginInteractorTests: XCTestCase {
    
    var sut: CreateLoginInteractor!
    var dataSourceMock: CreateLoginModel.DataSource!
    var presenterMock: CreateLoginPresentationLogicMock!
    var createLoginMock: CreateLoginWorkerMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = CreateLoginModel.DataSource()
        presenterMock = CreateLoginPresentationLogicMock()
        createLoginMock = CreateLoginWorkerMock()
        sut = CreateLoginInteractor(viewController: nil,
                                    dataSource: dataSourceMock,
                                    createLoginWorker: createLoginMock
        )
        sut.presenter = presenterMock
    }
    
    override func tearDown() {
        presenterMock = nil
        dataSourceMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testTryCreateLoginSucess() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.anyPassword, login: TestStrings.anyPassword)
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, nil)
        }

        // When
        sut.tryCreateLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.success)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.userSuccessfullyCreatedMessage)
    }
    
    func testTryCreateLoginErrorWrongFormatEmail() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.anyPassword, login: TestStrings.incorretEmail)
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17008, userInfo:nil))
        }

        // When
        sut.tryCreateLogin(request: request)

        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.incorrectEmailFormat)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.incorrectEmailFormatMessage)
    }
    
    func testTryCreateLoginErrorEmailAlreadyInUse() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.anyPassword, login: TestStrings.anyLogin)
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17007, userInfo:nil))
        }

        // When
        sut.tryCreateLogin(request: request)

        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.emailAlreadyInUse)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.emailAlreadyInUseMessage)
    }
    
    func testTryCreateLoginErrorShortPassword() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.sortPassword, login: TestStrings.anyLogin)
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17026, userInfo:nil))
        }

        // When
        sut.tryCreateLogin(request: request)

        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.passwordRule)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.passwordRuleMessage)
    }
    
    func testDoCreateLoginFieldPasswordEmpty() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.stringEmpty, login: TestStrings.anyLogin)
        
        // When
        sut.doCreateLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.errorInPasswordField)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.errorInPasswordFieldMessage)

    }
    
    func testDoCreateLoginFieldLoginEmpty() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.anyPassword, login: TestStrings.stringEmpty)
        
        // When
        sut.doCreateLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, TestStrings.errorInLoginField)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, TestStrings.errorInLoginFieldMessage)

    }
    
    func testDoCreateLoginSucess() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: TestStrings.anyPassword, login: TestStrings.anyLogin)
        
        // When
        sut.doCreateLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)

    }
}

class CreateLoginPresentationLogicMock: CreateLoginPresentationLogic {
    
    var presentStartLoadingCalled = false
    var presentStopLoadingCalled = false
    var presentShowAlertCalled = false
    var presentShowAlertResponse: CreateLoginModel.CreateLogin.Response?
    
    func presentShowAlert(_ response: CreateLoginModel.CreateLogin.Response) {
        presentShowAlertCalled = true
        presentShowAlertResponse = response
    }
    
    func presentStartLoading(_ response: CreateLoginModel.CreateLogin.Response) {
        presentStartLoadingCalled = true
    }
    
    func presentStopLoading(_ response: CreateLoginModel.CreateLogin.Response) {
        presentStopLoadingCalled = true
    }
}
