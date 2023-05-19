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
                results: [Result(
                    adult: false,
                    backdropPath: "",
                    genreIDS: [0],
                    id: 0,
                    originalLanguage: "",
                    originalTitle: "",
                    overview: "",
                    popularity: 0.0,
                    posterPath: "",
                    releaseDate: "",
                    title: "",
                    video: false,
                    voteAverage: 0.0,
                    voteCount: 0)],
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
        let request = LoginModel.Login.Request(password: "teste123", login: "teste@gmail.com")
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
        let request = LoginModel.Login.Request(password: "teste123", login: "teste@gmail.com")
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17008, userInfo:nil))
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Formato do email incorreto!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "O endereço de e-mail não parece ser valido")
    }
    
    func testTryLoginUserNotFound() {
        // Given
        let request = LoginModel.Login.Request(password: "teste123", login: "teste@gmail.com")
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17011, userInfo:nil))
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Usuario não encontrado!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Não há registro de usuário correspondente a este email, confira o email ou cadastre um novo usuário.")
    }
    
    func testTryLoginWrongPassword() {
        // Given
        let request = LoginModel.Login.Request(password: "teste123", login: "teste@gmail.com")
        loginWorkerMock.singInCompletion = { email, password, completion in
            completion?(nil, NSError(domain:"", code: 17009, userInfo:nil))
        }

        // When
        sut.tryLogin(request: request)
        
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
        XCTAssertTrue(presenterMock.presentStopLoadingCalled)
        XCTAssertTrue(presenterMock.presentShowAlertCalled)

        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Senha inválida!")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "A senha é inválida ou o usuário não possui uma senha.")
    }
    
    func testDoLoginFieldPasswordEmpty() {
        // Given
        let request = LoginModel.Login.Request(password: "", login: "teste@gmail.com")
        
        // When
        sut.doLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Erro no campo Senha")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Preencha o campo Senha")
    }
    
    func testDoLoginFieldLoginEmpty() {
        // Given
        let request = LoginModel.Login.Request(password: "123456", login: "")
        
        // When
        sut.doLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentShowAlertCalled)
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.titleMessage, "Erro no campo Email")
        XCTAssertEqual(presenterMock.presentShowAlertResponse?.message, "Preencha o campo Email")
    }
    
    func testDoLoginSuccess() {
        // Given
        let request = LoginModel.Login.Request(password: "123456", login: "teste@gmail.com")
        
        // When
        sut.doLogin(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentStartLoadingCalled)
    }
    
    func testCleanTextFields() {
        // Given
        let request = LoginModel.Login.Request(password: "123456", login: "teste@gmail.com")
        
        // When
        sut.cleanFields(request)
      
        // Then
        XCTAssertTrue(presenterMock.presentCleanFieldsCalled)
    }
    
    func testSearchFilmList() {
        // Given
        let expectation = XCTestExpectation(description: "Receber resposta da API")
        let apiKey = "ac894a60b6f5b4abf7ff6c58dbc67ced"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
     
        // When
        sut.searchFilmList(apiKey: apiKey, urlString: urlString)
                
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.sut.dataSource.filmModelList, "A lista de filmes não deve ser nula")
            XCTAssertFalse(self.sut.dataSource.filmModelList.results.isEmpty, "A lista de filmes não deve estar vazia")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

class LoginWorkerMock: LoginWorkerProtocol {
    var singInCompletion: ((String, String,((AuthDataResult?, Error?) -> Void)?) -> Void)?
    func signIn(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        singInCompletion?(withEmail, password, completion)
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
