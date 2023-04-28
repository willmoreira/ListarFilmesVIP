//
//  ResetLoginViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 27/04/23.
//

import UIKit
import FirebaseAuth

class ResetLoginViewController: UIViewController, ResetLoginViewDelegate {
    
    var resetLoginView = ResetLoginView()
    
    override func loadView() {
        super.loadView()
        view = resetLoginView
        resetLoginView.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resetLoginButtonPressed() {
        getData()
    }
    
    func getData() {
        let email = resetLoginView.inputLogin.text!
        if !email.isEmpty {
            tryReset(email: email)
        } else {
            showAlert(title: "Erro no campo Email", message: "Preencha o campo Login")
        }
    }
    
    func tryReset(email: String) {
        self.resetLoginView.activityIndicator.startAnimating()
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            self.resetLoginView.activityIndicator.stopAnimating()
            if let error = error {
                if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.showAlert(title: "Usuário não encontrado", message: "Não há registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.")
                }
                return
            }
            self.goToLogin()
        }
    }
    
    func goToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
