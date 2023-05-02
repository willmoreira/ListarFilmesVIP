//
//  CreateLoginRouter.swift
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

protocol CreateLoginRouting {
  
  func routeTo(_ route: CreateLoginModel.Route)
}

final class CreateLoginRouter {
  
  private weak var viewController: UIViewController?
  
  init(viewController: UIViewController?) {
    self.viewController = viewController
  }
}


// MARK: - CreateLoginRouting
extension CreateLoginRouter: CreateLoginRouting {
  
  func routeTo(_ route: CreateLoginModel.Route) {
    DispatchQueue.main.async {
      switch route {
        
      case .dismissCreateLoginScene:
        self.dismissCreateLoginScene()
        
      case .xScene(let data):
        self.showXSceneBy(data)
      }
    }
  }
}


// MARK: - Private Zone
private extension CreateLoginRouter {
  
  func dismissCreateLoginScene() {
    viewController?.dismiss(animated: true)
  }
  
  func showXSceneBy(_ data: Int) {
    print("will show the next screen")
  }
}
