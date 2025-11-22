//
//  HistoryViewController.swift
//  ProyectoModulo2
//
//  Created by Franco Ruiz on 14/11/25.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var historyEntries: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
    }
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "HistoryCell")
        let entry = historyEntries[indexPath.row]
        cell.textLabel?.text = entry
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Historial de Juego"
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
