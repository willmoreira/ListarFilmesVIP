//
//  LoginView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit

class LoginView: UIView {
    
    lazy var titleLogin = UILabel()
    lazy var titleSenha = UILabel()


    lazy var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 24)

        return titleView
    }()

    lazy var inputLogin: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite seu login"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    lazy var inputSenha: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite sua senha"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var buttonLogar: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var buttonRecuperarSenha: UIButton = {
        let button = UIButton()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Recuperar senha", attributes: underlineAttribute)
        button.setAttributedTitle(underlineAttributedString, for: .normal)

        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }()
    
    lazy var buttonCadastrar: UIButton = {
        let button = UIButton()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Cadastrar", attributes: underlineAttribute)
        button.setAttributedTitle(underlineAttributedString, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }()
    
    var usuario = UsuarioModel(login: "login", senha: "senha")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInit()
    }
    
    private func setupInit() {
        self.titleView.text = "APP LISTA DE FILMES"
        self.titleLogin.text = "Login"
        self.inputLogin = inputLogin
        self.titleSenha.text = "Senha"
        self.inputSenha = inputSenha
        self.buttonLogar.setTitle("Entrar", for: .normal)
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLogin.translatesAutoresizingMaskIntoConstraints = false
        titleSenha.translatesAutoresizingMaskIntoConstraints = false
        inputLogin.translatesAutoresizingMaskIntoConstraints = false
        inputSenha.translatesAutoresizingMaskIntoConstraints = false
        buttonLogar.translatesAutoresizingMaskIntoConstraints = false
        buttonCadastrar.translatesAutoresizingMaskIntoConstraints = false
        buttonRecuperarSenha.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLogin)
        self.addSubview(titleSenha)
        self.addSubview(inputLogin)
        self.addSubview(inputSenha)
        self.addSubview(buttonLogar)
        self.addSubview(buttonCadastrar)
        self.addSubview(buttonRecuperarSenha)
        self.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            titleLogin.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 100),
            titleLogin.leftAnchor.constraint(equalTo: self.inputLogin.leftAnchor, constant: 0),
            
            inputLogin.topAnchor.constraint(equalTo: titleLogin.bottomAnchor, constant: 10),
            inputLogin.widthAnchor.constraint(equalToConstant: 300),
            inputLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleSenha.topAnchor.constraint(equalTo: inputLogin.bottomAnchor, constant: 50),
            titleSenha.leftAnchor.constraint(equalTo: self.inputLogin.leftAnchor, constant: 0),
            
            inputSenha.topAnchor.constraint(equalTo: titleSenha.bottomAnchor, constant: 10),
            inputSenha.widthAnchor.constraint(equalToConstant: 300),
            inputSenha.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonLogar.topAnchor.constraint(equalTo: inputSenha.bottomAnchor, constant: 50),
            buttonLogar.widthAnchor.constraint(equalToConstant: 150),
            buttonLogar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonRecuperarSenha.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            buttonRecuperarSenha.widthAnchor.constraint(equalToConstant: 200),
            buttonRecuperarSenha.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonCadastrar.topAnchor.constraint(equalTo: buttonRecuperarSenha.bottomAnchor, constant:10),
            buttonCadastrar.widthAnchor.constraint(equalToConstant: 200),
            buttonCadastrar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ])
    }
}

