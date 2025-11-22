//
//  ConfigurationViewController.swift
//  ProyectoModulo2
//
//  Created by Franco Ruiz on 14/11/25.
//

import UIKit

class ConfigurationViewController: UIViewController {

    let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Nombre del Jugador"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let gameModeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Por Rondas", "Por Puntos"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let roundsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let roundsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roundsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.value = 3
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let pointsContainerView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pointsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let winValueField: UITextField = {
        let field = UITextField()
        field.placeholder = "Puntos por ganar"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let loseValueField: UITextField = {
        let field = UITextField()
        field.placeholder = "Puntos por perder"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let requiredScoreField: UITextField = {
        let field = UITextField()
        field.placeholder = "Puntos para ganar la sesión"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
        
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continuar", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Información", for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        gameModeSegmentedControl.addTarget(self, action: #selector(gameModeChanged), for: .valueChanged)
        roundsSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        nameTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        winValueField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        loseValueField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        requiredScoreField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameTextField)
        contentStackView.addArrangedSubview(gameModeSegmentedControl)
        roundsContainerView.addSubview(roundsLabel)
        roundsContainerView.addSubview(roundsSlider)
        contentStackView.addArrangedSubview(roundsContainerView)
        pointsContainerView.addSubview(pointsStackView)
        pointsStackView.addArrangedSubview(winValueField)
        pointsStackView.addArrangedSubview(loseValueField)
        pointsStackView.addArrangedSubview(requiredScoreField)
        contentStackView.addArrangedSubview(pointsContainerView)
        contentStackView.addArrangedSubview(continueButton)
        contentStackView.addArrangedSubview(infoButton)
        setViewContainer()
        
    }
        
    func setViewContainer() {
        view.backgroundColor = .gray
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            roundsLabel.topAnchor.constraint(equalTo: roundsContainerView.topAnchor),
            roundsLabel.leadingAnchor.constraint(equalTo: roundsContainerView.leadingAnchor),
            roundsLabel.trailingAnchor.constraint(equalTo: roundsContainerView.trailingAnchor),
            roundsSlider.topAnchor.constraint(equalTo: roundsLabel.bottomAnchor, constant: 8),
            roundsSlider.leadingAnchor.constraint(equalTo: roundsContainerView.leadingAnchor),
            roundsSlider.trailingAnchor.constraint(equalTo: roundsContainerView.trailingAnchor),
            roundsSlider.bottomAnchor.constraint(equalTo: roundsContainerView.bottomAnchor),
            pointsStackView.topAnchor.constraint(equalTo: pointsContainerView.topAnchor),
            pointsStackView.leadingAnchor.constraint(equalTo: pointsContainerView.leadingAnchor),
            pointsStackView.trailingAnchor.constraint(equalTo: pointsContainerView.trailingAnchor),
            pointsStackView.bottomAnchor.constraint(equalTo: pointsContainerView.bottomAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func gameModeChanged(_ sender: UISegmentedControl) {
        let isRoundsMode = sender.selectedSegmentIndex == 0
        self.roundsContainerView.isHidden = !isRoundsMode
        self.pointsContainerView.isHidden = isRoundsMode
        validateFields()
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        roundsLabel.text = "Rondas para ganar: \(Int(roundedValue))"
    }
    
    @objc func validateFields() {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            setContinueButton(enabled: false)
            return
        }
        
        let isRoundsMode = gameModeSegmentedControl.selectedSegmentIndex == 0
        if isRoundsMode {
            setContinueButton(enabled: true)
        } else {
            let winText = winValueField.text ?? ""
            let loseText = loseValueField.text ?? ""
            let requiredText = requiredScoreField.text ?? ""
            
            if !winText.isEmpty && !loseText.isEmpty && !requiredText.isEmpty {
                setContinueButton(enabled: true)
            } else {
                setContinueButton(enabled: false)
            }
        }
    }
    
    func setContinueButton(enabled: Bool) {
        continueButton.isEnabled = enabled
        self.continueButton.alpha = enabled ? 1.0 : 0.5
    }
    
    @objc func continueButtonTapped() {
        let gameVC = GameViewController()
        gameVC.playerName = nameTextField.text ?? "Jugador"
        let isRoundsMode = gameModeSegmentedControl.selectedSegmentIndex == 0
        if isRoundsMode {
            gameVC.gameMode = .rounds
            gameVC.targetRounds = Int(roundsSlider.value)
        } else {
            gameVC.gameMode = .points
            gameVC.winValue = Int(winValueField.text ?? "1") ?? 1
            let loseVal = Int(loseValueField.text ?? "-1") ?? -1
            gameVC.loseValue = loseVal < 0 ? loseVal : -loseVal
            gameVC.targetScore = Int(requiredScoreField.text ?? "5") ?? 5
        }
        present(gameVC, animated: true)
    }
    
    @objc func infoButtonTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        if let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController {
        present(infoVC, animated: true, completion: nil)
        }
    }
}
