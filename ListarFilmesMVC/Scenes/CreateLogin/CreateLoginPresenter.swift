//
//  CreateLoginPresenter.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates(https://github.com/Andrei-Popilian/VIP_Design_Xcode_Template)
//  so you can apply clean architecture to your iOS and MacOS projects,
//  see more http://clean-swift.com
//

import Foundation

protocol CreateLoginPresentationLogic {
    func presentShowAlert(_ response: CreateLoginModel.CreateLogin.Response)
    func presentStartLoading()
    func presentStopLoading()
}

final class CreateLoginPresenter {
    private weak var viewController: CreateLoginDisplayLogic?
    
    init(viewController: CreateLoginDisplayLogic?) {
        self.viewController = viewController
    }
}

// MARK: - CreateLoginPresentationLogic
extension CreateLoginPresenter: CreateLoginPresentationLogic {
    func presentStartLoading() {
        self.viewController?.displayStartLoading()
    }
    
    func presentStopLoading() {
        self.viewController?.displayStopLoading()
    }
    
    func presentShowAlert(_ response: CreateLoginModel.CreateLogin.Response) {
        let viewModel = CreateLoginModel.CreateLogin.ViewModel(titleMessage: response.titleMessage, message: response.message)
        self.viewController?.displayShowAlert(viewModel)
    }
}

// MARK: - Private Zone
private extension CreateLoginPresenter {
    
}
