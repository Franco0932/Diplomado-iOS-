//
//  AuthenticationViewController.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    private let viewModel = AuthenticationViewModel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mi Diario"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authenticateButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Desbloquear"
        config.imagePadding = 8
        config.cornerStyle = .capsule
        
        let buttonn = UIButton(configuration: config)
        buttonn.addTarget(self, action: #selector(didTapAuthenticate), for: .touchUpInside)
        buttonn.translatesAutoresizingMaskIntoConstraints = false
        return buttonn
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.authenticateUser()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(authenticateButton)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -550),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            authenticateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            authenticateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authenticateButton.widthAnchor.constraint(equalToConstant: 200),
            authenticateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapAuthenticate() {
        viewModel.authenticateUser()
    }
}

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    func authenticationSuccessful() {
        dismiss(animated: true)
    }
    
    func authenticationFailed(error: String) {
        let alert = UIAlertController(title: "Acceso Denegado", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { [weak self] _ in
            self?.viewModel.authenticateUser()
        }))
        present(alert, animated: true)
    }
}
