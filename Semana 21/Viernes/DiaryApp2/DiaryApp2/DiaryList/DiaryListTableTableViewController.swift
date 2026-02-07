//
//  DiaryListTableTableViewController.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit

import UIKit

class DiaryListTableViewController: UITableViewController {
    
    private let viewModel = DiaryListViewModel()
    private var hasAuthenticated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadEntries()
        tableView.reloadData()
        
        if !hasAuthenticated {
            let authVC = AuthenticationViewController()
            authVC.isModalInPresentation = true
            present(authVC, animated: true) { [weak self] in
                self?.hasAuthenticated = true
            }
        }
    }
    
    private func setupView() {
        title = "Mi Diario"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DiaryCell")
    }
    
    @objc private func didTapAdd() {
        let editorVC = EntryEditorViewController()
        navigationController?.pushViewController(editorVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEntries
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath)
        let entry = viewModel.entry(at: indexPath.row)
        
        var config = cell.defaultContentConfiguration()
        config.text = entry.title.isEmpty ? "Sin Título" : entry.title
        config.secondaryText = entry.date.formatted(date: .abbreviated, time: .shortened)
        
        if entry.isDraft {
            config.image = UIImage(systemName: "pencil.circle.fill")
            config.imageProperties.tintColor = .systemOrange
            config.secondaryTextProperties.color = .systemOrange
        } else {
            config.image = nil
            config.secondaryTextProperties.color = .secondaryLabel
        }
        
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entry = viewModel.entry(at: indexPath.row)
        
        if entry.isDraft {
            let editorVC = EntryEditorViewController(entry: entry)
            navigationController?.pushViewController(editorVC, animated: true)
        } else {
            let detailVC = EntryDetailViewController(entry: entry)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
