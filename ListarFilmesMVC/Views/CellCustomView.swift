//
//  CellCustomView.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 28/04/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let customImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Adicione as subviews à célula personalizada
        contentView.addSubview(customImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subtitleLabel)
        
        // Personalize a aparência da célula
        customImageView.layer.cornerRadius = customImageView.frame.size.width / 2
        customImageView.clipsToBounds = true
        
        // Configure as restrições para as subviews
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 50),
            customImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure a seleção da célula
    }

}
