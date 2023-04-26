//
//  LoginViewController.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
   
    var loginView = LoginView()
    
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
        
    }
    
    func buttonIrParaTelaListaFilmes() {
        let telalistaFilmes = ListaFilmesViewController()
        telalistaFilmes.viewFilmes.listFilmes = [FilmeModel(id: 1, nome: "Homem de ferro", descricao: "Filme de ficção 1", imagem: ""),
                                                 FilmeModel(id: 1, nome: "Pantera negra", descricao: "Filme de ficção 2", imagem: "")]
        navigationController?.pushViewController(telalistaFilmes, animated: true)
    }
}
