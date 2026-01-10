//
//  ViewController.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import UIKit

class TypeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var pokemonType: PokeType?
    var doubleDamageTo: [String] = []
    var doubleDamageReceived: [String] = []
    var halfDamageDealt: [String] = []
    var halfDamageReceived: [String] = []
    var notAffectedBy: [String] = []
    var noEffectAgainst: [String] = []
    
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
        title = pokemonType?.name
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        if let type = pokemonType {
            doubleDamageTo = type.doubleDamageTo
            doubleDamageReceived = type.doubleDamageReceived
            halfDamageDealt = type.halfDamageDealt
            halfDamageReceived = type.halfDamageReceived
            notAffectedBy = type.notAffectedBy
            noEffectAgainst = type.noEffectAgainst
            headerImageView.image = UIImage(named: type.imageType)
        }
        view.addSubview(tableView)
        let headerContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        headerImageView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 110)
        headerContainer.addSubview(headerImageView)
        tableView.tableHeaderView = headerContainer
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Fuerte Contra (x2)"
        case 1: return "Débil Contra (x2)"
        case 2: return "Daño Reducido A (x0.5)"
        case 3: return "Resistente A (x0.5)"
        case 4: return "Inmune A (x0)"
        case 5: return "Sin Efecto Contra (x0)"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = getArray(for: section)
        return array.isEmpty ? 1 : array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        
        let array = getArray(for: indexPath.section)
        
        var typeName = ""
        
        if !array.isEmpty {
            typeName = array[indexPath.row]
            cell.textLabel?.text = typeName
            if let iconName = DataRepository.shared.getIconName(for: typeName) {
                cell.imageView?.image = UIImage(named: iconName)
            } else {
                cell.imageView?.image = nil
            }
        } else {
            cell.textLabel?.text = typeName
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    private func getArray(for section: Int) -> [String] {
        switch section {
        case 0: return doubleDamageTo
        case 1: return doubleDamageReceived
        case 2: return halfDamageDealt
        case 3: return halfDamageReceived
        case 4: return notAffectedBy
        case 5: return noEffectAgainst
        default: return []
        }
    }
}
