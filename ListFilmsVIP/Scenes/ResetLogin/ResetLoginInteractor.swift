//
//  ResetLoginInteractor.swift
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

typealias ResetLoginInteractable = ResetLoginBusinessLogic & ResetLoginDataStore

protocol ResetLoginBusinessLogic {
    func doResetLogin(_ request: ResetLoginModel.ResetLogin.Request)
}

protocol ResetLoginDataStore {
    var dataSource: ResetLoginModel.DataSource { get }
}

final class ResetLoginInteractor: ResetLoginDataStore {
    
    var dataSource: ResetLoginModel.DataSource
    var presenter: ResetLoginPresentationLogic
    var resetLoginWorker: ResetLoginWorkerProtocol
    
    init(viewController: ResetLoginDisplayLogic?,
         dataSource: ResetLoginModel.DataSource,
         resetLoginWorker: ResetLoginWorkerProtocol = ResetLoginWorker()) {
        self.dataSource = dataSource
        self.resetLoginWorker = resetLoginWorker
        self.presenter = ResetLoginPresenter(viewController: viewController)
    }
    
    func tryResetLogin(request: ResetLoginModel.ResetLogin.Request){
        let reponseLoading = ResetLoginModel.ResetLogin.Response()
        presenter.presentStartLoading(reponseLoading)
        var response = ResetLoginModel.ResetLogin.Response(
            titleMessage: ProjectStrings.success.localized,
            message: ProjectStrings.guidelinesHaveBeenSentToYourEmail.localized
        )
        
        if let login = request.login {
            resetLoginWorker.resetUser(withEmail: login) { error in
                self.presenter.presentStopLoading(reponseLoading)
                if let error = error as? NSError{
                    if error.code == 17011 {
                        response = ResetLoginModel.ResetLogin.Response(
                            titleMessage: ProjectStrings.userNotFound.localized,
                            message: ProjectStrings.userNotFoundMessage2.localized)
                        self.presenter.presentShowAlert(response)
                    }
                    return
                }
                self.presenter.presentShowAlert(response)
            }
        }
    }
}

// MARK: - ResetLoginBusinessLogic
extension ResetLoginInteractor: ResetLoginBusinessLogic {
    func doResetLogin(_ request: ResetLoginModel.ResetLogin.Request) {
        guard let username = request.login, !username.isEmpty else {
            let response = ResetLoginModel.ResetLogin.Response(
                titleMessage: ProjectStrings.errorInLoginField.localized,
                message: ProjectStrings.errorInLoginFieldMessage.localized)
            presenter.presentShowAlert(response)
            return
        }
        tryResetLogin(request: request)
    }
}
