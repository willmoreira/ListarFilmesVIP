//
//  CreateLoginView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 27/04/23.
//

import UIKit

protocol CreateLoginViewDelegate: AnyObject {
    func botaoCriarPressionado()
}

class CreateLoginView: UIView {
    
    weak var delegate: CreateLoginViewDelegate?
    let activityIndicator = UIActivityIndicatorView(style: .large)

    lazy var titleLogin = UILabel()
    lazy var titleSenha = UILabel()

    lazy var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 24)
        return titleView
    }()

    lazy var inputLogin: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite seu email"
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
        button.addTarget(self, action: #selector(botaoCriarPressionado), for: .touchUpInside)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInit()
    }
    
    private func setupInit() {
        self.titleView.text = "CADASTRAR LOGIN"
        self.titleLogin.text = "Email"
        self.inputLogin = inputLogin
        self.titleSenha.text = "Senha"
        self.inputSenha = inputSenha
        self.buttonLogar.setTitle("Cadastrar", for: .normal)
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLogin.translatesAutoresizingMaskIntoConstraints = false
        titleSenha.translatesAutoresizingMaskIntoConstraints = false
        inputLogin.translatesAutoresizingMaskIntoConstraints = false
        inputSenha.translatesAutoresizingMaskIntoConstraints = false
        buttonLogar.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLogin)
        self.addSubview(titleSenha)
        self.addSubview(inputLogin)
        self.addSubview(inputSenha)
        self.addSubview(buttonLogar)
        self.addSubview(titleView)
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
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
        ])
    }

    @objc func botaoCriarPressionado() {
        delegate?.botaoCriarPressionado()
    }
    
}

