//
//  CountryDetailViewController.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import UIKit

class CountryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var country: CountryModel?
    
    let tableView = UITableView()
    let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = country?.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "⏎", style: .done, target: self, action: #selector(close))
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stateCell")
        view.addSubview(tableView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
        guard let data = country else { return }
        let flagImg = UIImageView(image: UIImage(named: data.flagImageName))
        flagImg.contentMode = .scaleAspectFit
        flagImg.frame = CGRect(x: 20, y: 10, width: view.frame.width - 40, height: 120)
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 140, width: view.frame.width - 40, height: 80))
        infoLabel.numberOfLines = 0
        infoLabel.text = "Capital: \(data.capital)\nIdioma: \(data.language)"
        let currencyBtn = UIButton(type: .system)
        currencyBtn.frame = CGRect(x: 20, y: 230, width: view.frame.width - 40, height: 50)
        currencyBtn.setTitle("Moneda: \(data.currencyCode)", for: .normal)
        currencyBtn.addTarget(self, action: #selector(goToCurrency), for: .touchUpInside)
        headerView.addSubview(flagImg)
        headerView.addSubview(infoLabel)
        headerView.addSubview(currencyBtn)
        tableView.tableHeaderView = headerView
    }
    
    @objc func close() { dismiss(animated: true) }
    
    @objc func goToCurrency() {
            guard let code = country?.currencyCode else { return }
            dismiss(animated: true) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first(where: { $0.isKeyWindow }),
                   let tabBar = window.rootViewController as? TabBarController {
                    tabBar.jumpToCurrency(targetCurrency: code)
                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country?.states.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        cell.textLabel?.text = country?.states[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poiVC = POIViewController()
        poiVC.state = country?.states[indexPath.row]
        navigationController?.pushViewController(poiVC, animated: true)
    }
}
