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
        let request = CreateLoginModel.CreateLogin.Request(password: "teste123", login: "teste@gmail.com")
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, nil)
        }

        // When
        sut.tryCreateLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Sucesso!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Usuario cadastrado com sucesso, faça o Login agora!")
    }
    
    func testTryCreateLoginErrorWrongFormatEmail() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: "teste123", login: "teste")
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17008, userInfo:nil))
        }

        // When
        sut.tryCreateLogin(request: request)

        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Formato do email incorreto!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "O endereço de e-mail não parece ser valido")
    }
    
    func testTryCreateLoginErrorEmailAlreadyInUse() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: "teste123", login: "teste@gmail.com")
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17007, userInfo:nil))
        }

        // When
        sut.tryCreateLogin(request: request)

        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Email já em uso!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "O endereço de e-mail já está sendo usado por outra conta.")
    }
    
    func testTryCreateLoginErrorShortPassword() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: "teste", login: "teste@gmail.com")
        createLoginMock.createUserCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17026, userInfo:nil))
        }

        // When
        sut.tryCreateLogin(request: request)

        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Regra de senha")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "A senha deve ter 6 caracteres ou mais.")
    }
    
    func testDoCreateLoginFieldPasswordEmpty() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: "", login: "teste2@gmail.com")
        
        // When
        sut.doCreateLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Erro no campo Senha")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Preencha o campo Senha")

    }
    
    func testDoCreateLoginFieldLoginEmpty() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: "123456", login: "")
        
        // When
        sut.doCreateLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Erro no campo Email")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Preencha o campo Email")

    }
    
    func testDoCreateLoginSucess() {
        // Given
        let request = CreateLoginModel.CreateLogin.Request(password: "123456", login: "teste@gmail.com")
        
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
