//
//  FilmView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit

class FilmView: UIView {
    
    lazy var listFilms: [Result] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 24)
        return titleView
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
          configureView()
    }
    
    private func configureView() {
        self.titleView.text = "Lista de Filmes"
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        backgroundColor = .white
        addSubview(titleView)
        addSubview(tableView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor,constant: 100),
            titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
}

extension FilmView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        // Configure o nome, subtítulo e imagem
        cell.nameLabel.text = listFilms[indexPath.row].title
        cell.subtitleLabel.text = listFilms[indexPath.row].overview
        
        return cell
    }
}
