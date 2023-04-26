//
//  LoginViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()
    
    override func loadView() {
        
        super.loadView()
        view = loginView
        view.backgroundColor = .white

    }
    
}
