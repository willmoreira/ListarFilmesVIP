//
//  LoginViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, LoginViewDelegate {
    
    var loginView = LoginView()
    var listaFilmes: [Movie] = []
    var login: String = ""
    var senha: String = ""
    
    override func loadView() {
        super.loadView()
        view = loginView
        view.backgroundColor = .white
        loginView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buscarListaFilmes()
    }
    
    func buscarListaFilmes() {
        // Defina a URL da API e a chave de API
        let apiKey = "ac894a60b6f5b4abf7ff6c58dbc67ced"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        // Crie uma instância de URLSession
        let session = URLSession.shared
        
        // Crie uma instância de URLRequest com a URL da API
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        // Defina o método HTTP da requisição como GET
        request.httpMethod = "GET"
        
        // Crie uma task de data para enviar a requisição
        let task = session.dataTask(with: request) { data, response, error in
            // Verifique se houve um erro
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            // Verifique se há dados na resposta
            guard let data = data else {
                print("Não há dados na resposta")
                return
            }
            // Converta os dados em um objeto JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.listaFilmes = try decoder.decode([Movie].self, from: data)
                
            } catch {
                print("Erro ao converter dados em JSON: \(error.localizedDescription)")
            }
        }
        // Inicie a task de data
        task.resume()
    }
    
    func buttonLogarPressionado() {
        coletarDados()
    }
    
    func coletarDados() {
        senha = loginView.inputSenha.text!
        login = loginView.inputLogin.text!
        
        if !login.isEmpty {
            if !senha.isEmpty {
                loginView.activityIndicator.startAnimating()
                tryLogin()
            } else {
                showAlert(title: "Erro no campo Senha", message: "Preencha o campo Senha")
            }
        } else {
            showAlert(title: "Erro no campo Login", message: "Preencha o campo Login")
        }
    }
    
    func tryLogin() {
        Auth.auth().signIn(withEmail: login, password: senha) { authResult, error in
            
            self.loginView.activityIndicator.stopAnimating()
            
            if let error = error {
                if error.localizedDescription == "The password is invalid or the user does not have a password." {
                    self.showAlert(title: "Senha inválida!", message: "A senha é inválida ou o usuário não possui uma senha.")
                }
                if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.showAlert(title: "Usuario não encontrado!", message: "Não há registro de usuário correspondente a este email, confira o email ou cadastre um novo usuário.")
                }
                return
            }
            self.irParaTelaListaFilmes()
        }
    }
    
    func botaoResetPressionado() {
        let telaResetSenha = ResetLoginViewController()
        self.navigationController?.pushViewController(telaResetSenha, animated: true)
    }
    
    func botaoCriarPressionado() {
        let telaCriarLogin = CreateLoginViewController()
        self.navigationController?.pushViewController(telaCriarLogin, animated: true)
    }
    
    func irParaTelaListaFilmes() {
        let telalistaFilmes = ListFilmesViewController()
        telalistaFilmes.viewFilmes.listFilmes = self.listaFilmes
        self.navigationController?.pushViewController(telalistaFilmes, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
