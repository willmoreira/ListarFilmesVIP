//
//  CreateLoginViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 27/04/23.
//

import UIKit
import FirebaseAuth

class CreateLoginViewController: UIViewController, CreateLoginViewDelegate{
    
    var createLoginView = CreateLoginView()
    var listFilms: [Result] = []
    var login: String = ""
    var senha: String = ""
    
    override func loadView() {
        super.loadView()
        view = createLoginView
        view.backgroundColor = .white
        createLoginView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createButtonPressed() {
        getData()
    }
    
    func getData() {
        senha = createLoginView.inputSenha.text!
        login = createLoginView.inputLogin.text!
        
        if !login.isEmpty {
            if !senha.isEmpty {
                createLoginView.activityIndicator.startAnimating()
                tryCreateLogin()
            } else {
                showAlert(title: "Erro no campo Senha", message: "Preencha o campo Senha")
            }
        } else {
            showAlert(title: "Erro no campo Login", message: "Preencha o campo Login")
        }
    }
    
    func tryCreateLogin() {
        Auth.auth().createUser(withEmail: login, password: senha) { authResult, error in
            self.createLoginView.activityIndicator.stopAnimating()
            
            if let error = error {
                if error.localizedDescription == "The email address is already in use by another account." {
                    self.showAlert(title: "Email já em uso!", message: "O endereço de e-mail já está sendo usado por outra conta.")
                }
                if error.localizedDescription == "The email address is badly formatted." {
                    self.showAlert(title: "Formato do email incorreto!", message: "O endereço de e-mail não parece ser valido")
                }
                if error.localizedDescription == "The password must be 6 characters long or more." {
                    self.showAlert(title: "Regra de senha", message: "A senha deve ter 6 caracteres ou mais.")
                }
                return
            }
            self.showAlert(title: "Sucesso!", message: "Usuario cadastrado com sucesso, faça o Login agora!")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            if title == "Sucesso!" {
                self.goToLogin()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
}
