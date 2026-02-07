//
//  BranchListViewController.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import UIKit

class BranchListViewController: UIViewController {

    private let viewModel: BranchListViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(branches: [Branch]) {
        self.viewModel = BranchListViewModel(branches: branches)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BranchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfBranches
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        let branch = viewModel.branch(at: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = branch.name
        config.secondaryText = branch.address
        config.secondaryTextProperties.color = .secondaryLabel
        
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension BranchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let branch = viewModel.branch(at: indexPath)
        
        let detailVC = BranchDetailViewController(branch: branch)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
