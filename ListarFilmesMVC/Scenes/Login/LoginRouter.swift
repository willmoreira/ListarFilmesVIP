//
//  LoginRouter.swift
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

protocol LoginRouting {
    func routeTo(_ route: LoginModel.Route)
    func routeToCreateLogin(_ route: LoginModel.Login.Route)
    func routeToResetLogin(_ route: LoginModel.Login.Route)
    func routeToListfilms(_ route: LoginModel.Login.Route)
}

final class LoginRouter {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}


// MARK: - LoginRouting
extension LoginRouter: LoginRouting {
    func routeToCreateLogin(_ route: LoginModel.Login.Route) {
        //trocar depois pela certa
        let mainView = CreateLoginView()
        let dataSource = CreateLoginModel.DataSource()
        let createLoginViewController = CreateLoginViewController(mainView: mainView, dataSource: dataSource)
        self.viewController?.navigationController?.pushViewController(createLoginViewController, animated: true)
    }
    
    func routeToResetLogin(_ route: LoginModel.Login.Route) {
        //trocar depois pela certa
        let mainView = ResetLoginView()
        let dataSource = ResetLoginModel.DataSource()
        let resetLoginViewController = ResetLoginViewController(mainView: mainView, dataSource: dataSource)
        self.viewController?.navigationController?.pushViewController(resetLoginViewController, animated: true)
    }
    
    func routeToListfilms(_ route: LoginModel.Login.Route) {
        
    }
    
    
    func routeTo(_ route: LoginModel.Route) {
        DispatchQueue.main.async {
            switch route {
                
            case .dismissLoginScene:
                self.dismissLoginScene()
                
            case .xScene(let data):
                self.showXSceneBy(data)
            }
        }
    }
}


// MARK: - Private Zone
private extension LoginRouter {
    
    func dismissLoginScene() {
        viewController?.dismiss(animated: true)
    }
    
    func showXSceneBy(_ data: Int) {
        print("will show the next screen")
    }
}
