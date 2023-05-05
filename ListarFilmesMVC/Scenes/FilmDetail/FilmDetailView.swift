//
//  FilmDetailView.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates(https://github.com/Andrei-Popilian/VIP_Design_Xcode_Template)
//  so you can apply clean architecture to your iOS and MacOS projects,
//  see more http://clean-swift.com
//

import UIKit

protocol FilmDetailViewDelegate where Self: UIViewController {
    
    func sendDataBackToParent(_ data: Data)
}

final class FilmDetailView: UIView {
    
    weak var delegate: FilmDetailViewDelegate?
    var film: Result?
    
    var customImageView: UIImageView = {
        let myImg = UIImageView()
        myImg.contentMode = .scaleAspectFit
        return myImg
    }()
    
    var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 24)
        titleView.textAlignment = .center
        titleView.numberOfLines = 2
        return titleView
    }()
    
    var descriptLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
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
        setupLayout()
    }
    
    private func setupLayout() {
        
        if let img = film?.posterPath {
            configureImage(posterPath: img)
        }
        
        titleView.text = film?.title
        descriptLabel.text = film?.overview
        titleView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleView)
        addSubview(customImageView)
        addSubview(descriptLabel)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            customImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customImageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            customImageView.widthAnchor.constraint(equalToConstant: 350),
            customImageView.heightAnchor.constraint(equalToConstant: 350),
            
            descriptLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 16),
        ])
    }
    
    func configureImage(posterPath: String) {
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
        customImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
    }
    
    private enum ViewTrait {
        static let leftMargin: CGFloat = 10.0
    }
}
