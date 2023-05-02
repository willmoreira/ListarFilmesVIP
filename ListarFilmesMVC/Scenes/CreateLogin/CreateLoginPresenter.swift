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
  func presentResponse(_ response: CreateLoginModel.Response)
}

final class CreateLoginPresenter {
  private weak var viewController: CreateLoginDisplayLogic?
  
  init(viewController: CreateLoginDisplayLogic?) {
    self.viewController = viewController
  }
}


// MARK: - CreateLoginPresentationLogic
extension CreateLoginPresenter: CreateLoginPresentationLogic {
  
  func presentResponse(_ response: CreateLoginModel.Response) {
    
    switch response {
      
    case .doSomething(let newItem, let isItem):
      presentDoSomething(newItem, isItem)
    }
  }
}


// MARK: - Private Zone
private extension CreateLoginPresenter {
  
  func presentDoSomething(_ newItem: Int, _ isItem: Bool) {
    
    //prepare data for display and send it further
    
    viewController?.displayViewModel(.doSomething(viewModelData: NSObject()))
  }
}
