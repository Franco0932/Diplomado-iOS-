//
//  SearchViewController.swift
//  EjercicioGitHub
//
//  Created by Franco Ruiz on 10/01/26.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = UITextField()
    let callToActionButton = UIButton()
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
        updateButtonState()
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else { return }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    @objc func textDidChange() {
        updateButtonState()
    }
    
    func updateButtonState() {
        if isUsernameEntered {
            callToActionButton.isEnabled = true
            callToActionButton.configuration?.baseBackgroundColor = .systemGreen
        } else {
            callToActionButton.isEnabled = false
            callToActionButton.configuration?.baseBackgroundColor = .systemGray4
        }
    }
    
    func configureUI() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(callToActionButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "githubImage")
        usernameTextField.delegate = self
        usernameTextField.placeholder = "Enter a Username"
        usernameTextField.textAlignment = .center
        usernameTextField.layer.cornerRadius = 16
        usernameTextField.layer.borderWidth = 0
        usernameTextField.backgroundColor = .systemGray6
        usernameTextField.textColor = .label
        usernameTextField.tintColor = .systemGreen
        usernameTextField.font = .rounded(ofSize: 22, weight: .semibold)
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.minimumFontSize = 12
        usernameTextField.autocorrectionType = .no
        usernameTextField.returnKeyType = .go
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Get Followers"
        configuration.baseBackgroundColor = .systemGray4
        configuration.cornerStyle = .medium
        configuration.image = UIImage(systemName: "person.3")
        configuration.imagePadding = 6
        configuration.imagePlacement = .leading
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .rounded(ofSize: 18, weight: .bold)
            return outgoing
        }
        configuration.titleTextAttributesTransformer = transformer
        callToActionButton.configuration = configuration
        callToActionButton.isEnabled = false
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        callToActionButton.layer.shadowColor = UIColor.black.cgColor
        callToActionButton.layer.shadowOpacity = 0.4
        callToActionButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        callToActionButton.layer.shadowRadius = 5
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
