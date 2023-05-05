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
}

protocol LoginDataStore {
    var dataSource: LoginModel.DataSource { get }
}

final class LoginInteractor: LoginDataStore {
    
    var dataSource: LoginModel.DataSource
    
    private var presenter: LoginPresentationLogic
    
    init(viewController: LoginDisplayLogic?, dataSource: LoginModel.DataSource) {
        self.dataSource = dataSource
        self.presenter = LoginPresenter(viewController: viewController)
    }
    
    func tryLogin(request: LoginModel.Login.Request) {
        
        let response = LoginModel.Login.Response()
        presenter.presentStartLoading(response)
        
        if let login = request.login, let password = request.password {
            Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
                
                self.presenter.presentStopLoading(response)
                
                if let error = error {
                    if error.localizedDescription == "The password is invalid or the user does not have a password." {
                        let response = LoginModel.Login.Response(
                            titleMessage: "Senha inválida!",
                            message: "A senha é inválida ou o usuário não possui uma senha.")
                        self.presenter.presentShowAlert(response)
                    }
                    if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        let response = LoginModel.Login.Response(
                            titleMessage: "Usuario não encontrado!",
                            message: "Não há registro de usuário correspondente a este email, confira o email ou cadastre um novo usuário.")
                        self.presenter.presentShowAlert(response)
                    }
                    return
                }
                self.goToScreenListFilms()
            }
        }
    }
    
    func goToScreenListFilms() {
        searchFilmList()
    }
    
    func searchFilmList() {
        // Defina a URL da API e a chave de API
        let apiKey = "ac894a60b6f5b4abf7ff6c58dbc67ced"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        // Crie uma instância de URLSession
        let session = URLSession.shared
        
        // Crie uma instância de URLRequest com a URL da API
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        // Defina o método HTTP da requisição como GET
        request.httpMethod = "GET"
        
        // Crie uma task de data para enviar a requisição
        let task = session.dataTask(with: request) { data, response, error in
            // Verifique se houve um erro
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            // Verifique se há dados na resposta
            guard let data = data else {
                print("Não há dados na resposta")
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
                print("Erro ao converter dados em JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

// MARK: - LoginBusinessLogic
extension LoginInteractor: LoginBusinessLogic {
    
    func doLogin(_ request: LoginModel.Login.Request) {
        guard let username = request.login, !username.isEmpty else {
            let response = LoginModel.Login.Response(
                titleMessage: "Erro no campo Login",
                message: "Preencha o campo Login")
            presenter.presentShowAlert(response)
            return
        }
        guard let password = request.password, !password.isEmpty else {
            let response = LoginModel.Login.Response(
                titleMessage: "Erro no campo Senha",
                message: "Preencha o campo Senha")
            presenter.presentShowAlert(response)
            return
        }
        tryLogin(request: request)
    }
}

// MARK: - Private Zone
private extension LoginInteractor {
    
}
