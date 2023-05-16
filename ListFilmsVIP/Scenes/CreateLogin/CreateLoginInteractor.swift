//
//  CreateLoginInteractor.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation
import FirebaseAuth

typealias CreateLoginInteractable = CreateLoginBusinessLogic & CreateLoginDataStore

protocol CreateLoginBusinessLogic {
    func doCreateLogin(_ request: CreateLoginModel.CreateLogin.Request)
}

protocol CreateLoginDataStore {
    var dataSource: CreateLoginModel.DataSource { get }
}

final class CreateLoginInteractor: CreateLoginDataStore {
    
    var dataSource: CreateLoginModel.DataSource
    
    var presenter: CreateLoginPresentationLogic
    
    var createLoginWorker: CreateLoginWorkerProtocol
    
    init(viewController: CreateLoginDisplayLogic?,
         dataSource: CreateLoginModel.DataSource,
         createLoginWorker: CreateLoginWorkerProtocol = CreateLoginWorker()) {
        self.dataSource = dataSource
        self.createLoginWorker = createLoginWorker
        self.presenter = CreateLoginPresenter(viewController: viewController)
    }
    
    func tryCreateLogin(request: CreateLoginModel.CreateLogin.Request) {
    
        if let login = request.login, let password = request.password {
            let responseLoading = CreateLoginModel.CreateLogin.Response()
            presenter.presentStartLoading(responseLoading)
            
            var response = CreateLoginModel.CreateLogin.Response(
                titleMessage: "Sucesso!",
                message: "Usuario cadastrado com sucesso, faça o Login agora!")
            
            createLoginWorker.createUser(withEmail: login, password: password) { _, error in
                self.presenter.presentStopLoading(responseLoading)
                
                if let error = error as? NSError{
                    if error.code == 17007 {
                        response = CreateLoginModel.CreateLogin.Response(
                            titleMessage: "Email já em uso!",
                            message: "O endereço de e-mail já está sendo usado por outra conta.")
                        self.presenter.presentShowAlert(response)
                    }
                    if error.code == 17008 {
                        response = CreateLoginModel.CreateLogin.Response(
                            titleMessage: "Formato do email incorreto!",
                            message:  "O endereço de e-mail não parece ser valido")
                        self.presenter.presentShowAlert(response)
                    }
                    if error.code == 17026 {
                        response = CreateLoginModel.CreateLogin.Response(
                            titleMessage: "Regra de senha",
                            message:  "A senha deve ter 6 caracteres ou mais.")
                        self.presenter.presentShowAlert(response)
                    }
                    return
                }
                self.presenter.presentShowAlert(response)
            }
        }
    }
}

// MARK: - CreateLoginBusinessLogic
extension CreateLoginInteractor: CreateLoginBusinessLogic {
    func doCreateLogin(_ request: CreateLoginModel.CreateLogin.Request) {
        guard let username = request.login, !username.isEmpty else {
            let response = CreateLoginModel.CreateLogin.Response(
                titleMessage: "Erro no campo Email",
                message: "Preencha o campo Email")
            presenter.presentShowAlert(response)
            return
        }
        guard let password = request.password, !password.isEmpty else {
            let response = CreateLoginModel.CreateLogin.Response(
                titleMessage: "Erro no campo Senha",
                message: "Preencha o campo Senha")
            presenter.presentShowAlert(response)
            return
        }
        tryCreateLogin(request: request)
    }
}

// MARK: - Private Zone
private extension CreateLoginInteractor {
    
}
