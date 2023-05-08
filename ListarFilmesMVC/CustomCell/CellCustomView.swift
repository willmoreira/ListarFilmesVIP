//
//  CellCustomView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 28/04/23.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let customImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(customImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subtitleLabel)
        
        nameLabel.numberOfLines = 2
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        customImageView.layer.cornerRadius = customImageView.frame.size.width / 2
        customImageView.clipsToBounds = true
        
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 70),
            customImageView.heightAnchor.constraint(equalToConstant: 95),
            
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(posterPath: String) {
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
        customImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
