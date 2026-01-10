//
//  ViewController.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    static let identifier = "TypeCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = .boldSystemFont(ofSize: 16)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGroupedBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 60), // Tamaño del icono
            imageView.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with type: PokeType) {
        nameLabel.text = type.name
        imageView.image = UIImage(named: type.imageType)
    }
}
