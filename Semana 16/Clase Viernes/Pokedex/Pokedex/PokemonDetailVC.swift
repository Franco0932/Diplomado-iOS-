//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon?
    var evolutionChain: [Pokemon] = []
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.tableFooterView = UIView()
        return tv
    }()
    
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = pokemon?.name
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        if let p = pokemon {
            evolutionChain = DataRepository.shared.getEvolutionChain(for: p.id)
            headerImageView.image = UIImage(named: p.imageName)
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let headerContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        headerImageView.frame = headerContainer.bounds
        headerContainer.addSubview(headerImageView)
        tableView.tableHeaderView = headerContainer
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "EvoCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(toggleFav))
        updateFavIcon()
    }
    
    @objc func toggleFav() {
        guard let p = pokemon else { return }
        DataRepository.shared.toggleFavorite(id: p.id)
        updateFavIcon()
    }
    
    func updateFavIcon() {
        guard let p = pokemon else { return }
        let isFav = DataRepository.shared.isFavorite(id: p.id)
        navigationItem.rightBarButtonItem?.image = isFav ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
}

extension PokemonDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 4 }
        return evolutionChain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let p = pokemon else { return UITableViewCell() }
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = .white
            cell?.textLabel?.textColor = .black
            cell?.detailTextLabel?.textColor = .black
            cell?.accessoryView = nil
            
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "Nombre"
                cell?.detailTextLabel?.text = p.name
            case 1:
                cell?.textLabel?.text = "Número"
                cell?.detailTextLabel?.text = "#\(p.id)"
            case 2:
                cell?.textLabel?.text = "Tipo"
                cell?.detailTextLabel?.text = ""
                let stack = UIStackView()
                stack.axis = .horizontal
                stack.spacing = 5
                for typeName in p.types {
                    let iv = UIImageView(image: UIImage(named: "Icon_" + typeName))
                    iv.contentMode = .scaleAspectFit
                    iv.widthAnchor.constraint(equalToConstant: 25).isActive = true
                    iv.heightAnchor.constraint(equalToConstant: 25).isActive = true
                    stack.addArrangedSubview(iv)
                }
                let width = CGFloat(p.types.count * 30)
                stack.frame = CGRect(x: 0, y: 0, width: width, height: 25)
                cell?.accessoryView = stack
                
            case 3:
                cell?.textLabel?.text = p.description
                cell?.textLabel?.numberOfLines = 0
                cell?.detailTextLabel?.text = ""
            default: break
            }
            return cell!
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EvoCell", for: indexPath) as! SubtitleCell
            let evo = evolutionChain[indexPath.row]
            cell.backgroundColor = .white
            cell.textLabel?.text = evo.name
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.text = "Tipo: " + evo.types.joined(separator: ", ")
            cell.detailTextLabel?.textColor = .darkGray
            cell.imageView?.image = UIImage(named: evo.imageName)
            if evo.id == p.id {
                cell.accessoryType = .none
                cell.isUserInteractionEnabled = false
            } else {
                cell.accessoryType = .disclosureIndicator
                cell.isUserInteractionEnabled = true
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let nextPokemon = evolutionChain[indexPath.row]
            let nextVC = PokemonDetailVC()
            nextVC.pokemon = nextPokemon
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) { fatalError() }
}
