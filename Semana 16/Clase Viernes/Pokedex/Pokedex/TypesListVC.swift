//
//  ViewController.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import UIKit

class TypesListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.tableFooterView = UIView()
        return tv
    }()
    
    private let types = DataRepository.shared.allTypes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tipos"
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let type = types[indexPath.row]
        
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        cell.textLabel?.text = type.name
        cell.imageView?.image = UIImage(named: type.imageType)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = types[indexPath.row]
        let detailVC = TypeDetailVC()
        detailVC.pokemonType = selectedType
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
