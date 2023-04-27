//
//  LoginViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
   
    var loginView = LoginView()
    var listaFilmes: [Movie] = []
    
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
    
    func buttonIrParaTelaListaFilmes() {
        let telalistaFilmes = ListaFilmesViewController()
        telalistaFilmes.viewFilmes.listFilmes = listaFilmes
        navigationController?.pushViewController(telalistaFilmes, animated: true)
    }
}
