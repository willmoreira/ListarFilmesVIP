//
//  FilmView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit
import SDWebImage

protocol ListFilmViewDelegate: AnyObject {
    func goToDetailViewController(filmSelected: Result)
}

class ListFilmView: UIView {
    
    weak var delegate: ListFilmViewDelegate?
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

extension ListFilmView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmeSelecionado = listFilms[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.goToDetailViewController(filmSelected: filmeSelecionado)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        // Configure o nome, subtítulo e imagem
        cell.nameLabel.text = listFilms[indexPath.row].title
        cell.subtitleLabel.text = "Lançado em " + formatDate(date: listFilms[indexPath.row].releaseDate)
        cell.configureImage(posterPath: listFilms[indexPath.row].posterPath)

        return cell
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        var dateString: String = ""
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "pt_BR")
            dateString = dateFormatter.string(from: date)
        }
        return dateString
    }
}
