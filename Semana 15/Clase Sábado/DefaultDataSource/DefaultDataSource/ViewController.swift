//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Franco Ruiz on 22/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    typealias Item = String
    typealias Section = Int
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    var array: [String] = ["Platano", "Melon", "Fresa", "Durazno"]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dataSource = UITableViewDiffableDataSource(tableView: tableView) {
            tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item
            return cell
        }
        
        setSnapshot()
        addItem()
        
    }
    
    func setSnapshot () {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections([0])
        snapShot.appendItems((array))
        dataSource.apply(snapShot)
    }
    
    
    func addItem () {
        var snapShot = dataSource.snapshot()
        array.append("Guayaba")
        snapShot.appendItems(array)
        dataSource.apply(snapShot)
    }


}

