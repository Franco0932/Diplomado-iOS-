//
//  BandTableViewCell.swift
//  Ejercicio2Bandas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class BandTableViewCell: UITableViewCell {
    
    let bandImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let bandNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // No usaremos Storyboard
    }
    
    func setupUI() {
        contentView.addSubview(bandImageView)
        contentView.addSubview(bandNameLabel)
        
        NSLayoutConstraint.activate([
            bandImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bandImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bandImageView.widthAnchor.constraint(equalToConstant: 60),
            bandImageView.heightAnchor.constraint(equalToConstant: 60),            
            bandNameLabel.leadingAnchor.constraint(equalTo: bandImageView.trailingAnchor, constant: 16),
            bandNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bandNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
