//
//  LoginInteractor.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FirebaseAuth

typealias LoginInteractable = LoginBusinessLogic & LoginDataStore

protocol LoginBusinessLogic {
    func doLogin(_ request: LoginModel.Login.Request)
    func cleanFields(_ request: LoginModel.Login.Request)
}

protocol LoginDataStore {
    var dataSource: LoginModel.DataSource { get }
}

final class LoginInteractor: LoginDataStore {
    var dataSource: LoginModel.DataSource
    
    var presenter: LoginPresentationLogic
    
    var loginWorker: LoginWorkerProtocol
    
    init(viewController: LoginDisplayLogic?,
         dataSource: LoginModel.DataSource,
         loginWorker: LoginWorkerProtocol = LoginWorker()) {
        self.dataSource = dataSource
        self.loginWorker = loginWorker
        self.presenter = LoginPresenter(viewController: viewController)
    }
    
    func tryLogin(request: LoginModel.Login.Request) {
        let response = LoginModel.Login.Response()
        presenter.presentStartLoading(response)
        
        if let login = request.login, let password = request.password {
            loginWorker.signIn(withEmail: login, password: password) { authResult, error in
                self.presenter.presentStopLoading(response)
                if let error = error as? NSError{
                    if error.code == 17009 {
                        let response = LoginModel.Login.Response(
                            titleMessage: ProjectStrings.invalidPassword.localized,
                            message: ProjectStrings.invalidPasswordMessage.localized)
                        self.presenter.presentShowAlert(response)
                    }
                    if error.code == 17011 {
                        let response = LoginModel.Login.Response(
                            titleMessage: ProjectStrings.userNotFound.localized,
                            message: ProjectStrings.userNotFoundMessage.localized)
                        self.presenter.presentShowAlert(response)
                    }
                    if error.code == 17008 {
                        let response = LoginModel.Login.Response(
                            titleMessage: ProjectStrings.incorrectEmailFormat.localized,
                            message:  ProjectStrings.incorrectEmailFormatMessage.localized)
                        self.presenter.presentShowAlert(response)
                    }
                    return
                }
                self.goToScreenListFilms()
            }
        }
    }
    
    func goToScreenListFilms() {
        guard let configPath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let configDictionary = NSDictionary(contentsOfFile: configPath),
              let apiKey = configDictionary["API_KEY"] as? String else {
            fatalError("Arquivo de configuração 'Config.plist' não encontrado ou chave 'API_KEY' ausente.")
        }
        
        let urlString = ProjectStrings.urlString.localized + apiKey
        searchFilmList(apiKey: apiKey, urlString: urlString)
    }
    
    func searchFilmList(apiKey: String, urlString: String) {
        // Defina a URL da API e a chave de API
           
        // Crie uma instância de URLSession
        let session = URLSession.shared
        
        // Crie uma instância de URLRequest com a URL da API
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        // Defina o método HTTP da requisição como GET
        request.httpMethod = ProjectStrings.get.localized
        
        // Crie uma task de data para enviar a requisição
        let task = session.dataTask(with: request) { data, response, error in
            // Verifique se houve um erro
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            // Verifique se há dados na resposta
            guard let data = data else {
                return
            }
            // Converta os dados em um objeto JSON
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(FilmModel.self, from: data)
                self.dataSource.filmModelList = result
                let response = LoginModel.Login.Response()
                self.presenter.presentGoToListFilms(response)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

// MARK: - LoginBusinessLogic
extension LoginInteractor: LoginBusinessLogic {
    func cleanFields(_ request: LoginModel.Login.Request) {
        let response = LoginModel.Login.Response()
        presenter.presentCleanFields(response)
    }
    
    func doLogin(_ request: LoginModel.Login.Request) {
        guard let username = request.login, !username.isEmpty else {
            let response = LoginModel.Login.Response(
                titleMessage: ProjectStrings.errorInLoginField.localized,
                message: ProjectStrings.errorInLoginFieldMessage.localized)
            presenter.presentShowAlert(response)
            return
        }
        guard let password = request.password, !password.isEmpty else {
            let response = LoginModel.Login.Response(
                titleMessage: ProjectStrings.errorInPasswordField.localized,
                message: ProjectStrings.errorInPasswordFieldMessage.localized)
            presenter.presentShowAlert(response)
            return
        }
        tryLogin(request: request)
    }
}
