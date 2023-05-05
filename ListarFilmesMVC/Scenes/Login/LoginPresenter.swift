//
//  LoginPresenter.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates(https://github.com/Andrei-Popilian/VIP_Design_Xcode_Template)
//  so you can apply clean architecture to your iOS and MacOS projects,
//  see more http://clean-swift.com
//

import UIKit

protocol LoginPresentationLogic {
    func presentShowAlert(_ response: LoginModel.Login.Response)
    func presentStartLoading()
    func presentStopLoading()

}

final class LoginPresenter {
    private weak var viewController: LoginDisplayLogic?
    
    init(viewController: LoginDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - LoginPresentationLogic
extension LoginPresenter: LoginPresentationLogic {
    func presentStartLoading() {
        self.viewController?.displayStartLoading()
    }
    
    func presentStopLoading() {
        self.viewController?.displayStopLoading()
    }
    
    func presentShowAlert(_ response: LoginModel.Login.Response) {
        let viewModel = LoginModel.Login.ViewModel(titleMessage:response.titleMessage , message: response.message)
        self.viewController?.diplayShowAlert(viewModel)
    }
}


// MARK: - Private Zone
private extension LoginPresenter {
    
    
}
