//
//  POIViewController.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import UIKit

class POIViewController: UITableViewController {
    var state: StateModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = state?.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state?.pointsOfInterest.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = state?.pointsOfInterest[indexPath.row]
        return cell
    }
}

