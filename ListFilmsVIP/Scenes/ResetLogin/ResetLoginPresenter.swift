//
//  ResetLoginPresenter.swift
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

protocol ResetLoginPresentationLogic {
    func presentStartLoading(_ response: ResetLoginModel.ResetLogin.Response)
    func presentStopLoading(_ response: ResetLoginModel.ResetLogin.Response)
    func presentShowAlert(_ response: ResetLoginModel.ResetLogin.Response)
}

final class ResetLoginPresenter {
    private weak var viewController: ResetLoginDisplayLogic?
    
    init(viewController: ResetLoginDisplayLogic?) {
        self.viewController = viewController
    }
}

// MARK: - ResetLoginPresentationLogic
extension ResetLoginPresenter: ResetLoginPresentationLogic {
    func presentShowAlert(_ response: ResetLoginModel.ResetLogin.Response) {
        let viewModel = ResetLoginModel.ResetLogin.ViewModel(titleMessage: response.titleMessage, message: response.message)
        self.viewController?.displayShowAlert(viewModel)
    }
    
    func presentStartLoading(_ response: ResetLoginModel.ResetLogin.Response) {
        let viewModel = ResetLoginModel.ResetLogin.Response()
        self.viewController?.displayStartLoading(viewModel)
    }
    
    func presentStopLoading(_ response: ResetLoginModel.ResetLogin.Response) {
        let viewModel = ResetLoginModel.ResetLogin.Response()
        self.viewController?.displayStopLoading(viewModel)
    }
}