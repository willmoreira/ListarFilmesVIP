//
//  ResetLoginInteractorTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP
import FirebaseAuth

final class ResetLoginInteractorTests: XCTestCase {
    
    var sut: ResetLoginInteractor!
    var dataSourceMock: ResetLoginModel.DataSource!
    var presenterMock: ResetLoginPresentationLogicMock!
    var resetLoginMock: ResetLoginWorkerMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = ResetLoginModel.DataSource()
        presenterMock = ResetLoginPresentationLogicMock()
        resetLoginMock = ResetLoginWorkerMock()
        sut = ResetLoginInteractor(viewController: nil,
                                   dataSource: dataSourceMock,
                                   resetLoginWorker: resetLoginMock)
        sut.presenter = presenterMock
    }
    
    override func tearDown() {
        presenterMock = nil
        dataSourceMock = nil
        resetLoginMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testResetLoginSucess() {
        // Given
        let request = ResetLoginModel.ResetLogin.Request(login: "teste@gmail.com")
        resetLoginMock.resetUserCompletion = { email, completion in
            completion?(nil)
        }
        // When
        sut.tryResetLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Sucesso!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "As orientações foram enviadas para seu email!")
    }
    
    func testResetLoginErrorUserNotFound() {
        // Given
        let request = ResetLoginModel.ResetLogin.Request(login: "teste@gmail.com")
        resetLoginMock.resetUserCompletion = { email, completion in
            completion?(NSError(domain:"", code: 17011, userInfo:nil))
        }
        
        // When
        sut.tryResetLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Usuário não encontrado")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Não há registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.")
    }
    
    func testDoResetLoginSuccess() {
        
        //Given
        let request = ResetLoginModel.ResetLogin.Request(login:"")
        
        //When
        sut.doResetLogin(request)
        
        //Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Erro no campo Login")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Preencha o campo Login")
        
        
    }
    
    func testDoResetLoginErrorEmptyField() {
        //Given
        let request = ResetLoginModel.ResetLogin.Request(login:"teste@gmail.com")
        
        //When
        sut.doResetLogin(request)
        
        //Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
    }
}


class ResetLoginPresentationLogicMock: ResetLoginPresentationLogic {
    
    var presentStartLoadingCalled = false
    var presentStopLoadingCalled = false
    var presentShowAlertCalled = false
    var presentShowAlertResponse: ResetLoginModel.ResetLogin.Response?
    
    func presentStartLoading(_ response: ListarFilmesVIP.ResetLoginModel.ResetLogin.Response) {
        presentStartLoadingCalled = true
    }
    
    func presentStopLoading(_ response: ListarFilmesVIP.ResetLoginModel.ResetLogin.Response) {
        presentStopLoadingCalled = true
    }
    
    func presentShowAlert(_ response: ListarFilmesVIP.ResetLoginModel.ResetLogin.Response) {
        presentShowAlertCalled = true
        presentShowAlertResponse = response
    }
}

class ResetLoginWorkerMock: ResetLoginWorkerProtocol {
    
    var resetUserCompletion: ((String,((Error?) -> Void)?) -> Void)?
    
    func resetUser(withEmail: String, completion: ((Error?) -> Void)?) {
        resetUserCompletion?(withEmail, completion)
    }
}

