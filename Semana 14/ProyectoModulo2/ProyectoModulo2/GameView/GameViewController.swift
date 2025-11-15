//
//  GameViewController.swift
//  ProyectoModulo2
//
//  Created by Franco Ruiz on 14/11/25.
//

import UIKit

enum GameChoice: Int {
    case rock = 0, paper, scissors

    var image: String {
        switch self {
        case .rock: return "🪨"
        case .paper: return "📄"
        case .scissors: return "✂️"
        }
    }
    var displayName: String {
        switch self {
        case .rock: return "Piedra"
        case .paper: return "Papel"
        case .scissors: return "Tijeras"
        }
    }
    var emoji: String {
            switch self {
            case .rock: return "🪨"
            case .paper: return "📄"
            case .scissors: return "✂️"
            }
        }
}

enum GameOutcome {
    case win, lose, tie
    
    var backgroundColor: UIColor {
        switch self {
        case .win: return .systemGreen
        case .lose: return .systemRed
        case .tie: return .brown
        }
    }
}


class GameViewController: UIViewController {
    var playerName: String = "Jugador"
    var gameMode: GameMode = .rounds
    var targetRounds: Int = 3
    var winValue: Int = 1
    var loseValue: Int = -1
    var targetScore: Int = 5
    
    private var currentScore: Int = 0
    private var gameHistory: [String] = []

    
    let opponentChoiceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 80)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Puntaje: 0"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let choiceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var rockButton = createChoiceButton(choice: .rock)
    lazy var paperButton = createChoiceButton(choice: .paper)
    lazy var scissorsButton = createChoiceButton(choice: .scissors)

    let nextTurnButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Siguiente Turno", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reiniciar", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Historial", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        rockButton.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
        scissorsButton.setImage(UIImage(named: "icons8-scissors-48"), for: .normal)
        nextTurnButton.addTarget(self, action: #selector(nextTurnTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetGameTapped), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        updateScoreLabel()
        setViewContainer()
    }
        
    func setViewContainer() {
        choiceStackView.addArrangedSubview(rockButton)
        choiceStackView.addArrangedSubview(paperButton)
        choiceStackView.addArrangedSubview(scissorsButton)
        view.addSubview(opponentChoiceLabel)
        view.addSubview(resultLabel)
        view.addSubview(scoreLabel)
        view.addSubview(choiceStackView)
        view.addSubview(nextTurnButton)
        view.addSubview(resetButton)
        view.addSubview(historyButton)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            opponentChoiceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            opponentChoiceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: opponentChoiceLabel.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            choiceStackView.bottomAnchor.constraint(equalTo: nextTurnButton.topAnchor, constant: -30),
            choiceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            choiceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextTurnButton.bottomAnchor.constraint(equalTo: historyButton.topAnchor, constant: -20),
            nextTurnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextTurnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextTurnButton.heightAnchor.constraint(equalToConstant: 44),
            historyButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -10),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    @objc func gameButtonTapped(_ sender: UIButton) {
        guard let userChoice = GameChoice(rawValue: sender.tag) else { return }
        let opponentChoice = generateOpponentChoice()
        let outcome = determineOutcome(userChoice: userChoice, opponentChoice: opponentChoice)
        updateUIForOutcome(outcome, userChoice: userChoice, opponentChoice: opponentChoice)
        updateScore(for: outcome)
        toggleGameControls(enabled: false)
        let gameDidEnd = checkWinCondition()
        if !gameDidEnd {
            nextTurnButton.isHidden = false
        }
    }
    
    func generateOpponentChoice() -> GameChoice {
        let randomChoice = Int.random(in: 0...2)
        return GameChoice(rawValue: randomChoice)!
    }
    
    func determineOutcome(userChoice: GameChoice, opponentChoice: GameChoice) -> GameOutcome {
        if userChoice == opponentChoice {
            return .tie
        }
        
        switch userChoice {
        case .rock:
            return (opponentChoice == .scissors) ? .win : .lose
        case .paper:
            return (opponentChoice == .rock) ? .win : .lose
        case .scissors:
            return (opponentChoice == .paper) ? .win : .lose
        }
    }
    
    func updateUIForOutcome(_ outcome: GameOutcome, userChoice: GameChoice, opponentChoice: GameChoice) {
        view.backgroundColor = outcome.backgroundColor
        let resultString: String
        switch outcome {
        case .win:
            resultString = "\(playerName) gana"
        case .lose:
            resultString = "\(playerName) pierde"
        case .tie:
            resultString = "Empate"
        }
        
        resultLabel.text = resultString
        let historyEntry = "\(playerName): \(userChoice.displayName) vs App: \(opponentChoice.displayName). Resultado: \(resultString)"
        gameHistory.append(historyEntry)
    }
    
    func updateScore(for outcome: GameOutcome) {
        switch gameMode {
        case .rounds:
            if outcome == .win {
                currentScore += 1
            }
        case .points:
            if outcome == .win {
                currentScore += winValue
            } else if outcome == .lose {
                currentScore += loseValue
            }
            if currentScore < 0 {
                currentScore = 0
            }
        }
        updateScoreLabel()
    }
    
    func checkWinCondition() -> Bool {
        var showVictoryAlert = false
        
        switch gameMode {
        case .rounds:
            if currentScore == targetRounds {
                showVictoryAlert = true
            }
        case .points:
            if currentScore >= targetScore {
                showVictoryAlert = true
            }
        }
        
        if showVictoryAlert {
            showGameEndAlert(title: "Felicidades, \(playerName)!", message: "Has ganado")
            return true
        }
        
        return false
    }
    
    @objc func nextTurnTapped() {
        view.backgroundColor = .gray
        nextTurnButton.isHidden = true
        toggleGameControls(enabled: true)
        opponentChoiceLabel.text = nil
    }
    
    @objc func resetGameTapped() {
        currentScore = 0
        gameHistory.removeAll()
        updateScoreLabel()
        nextTurnTapped()
    }
    
    @objc func historyButtonTapped() {
        let historyVC = HistoryViewController(nibName: "HistoryView", bundle: nil)
        historyVC.historyEntries = self.gameHistory
        present(historyVC, animated: true)
    }
    
    
    func createChoiceButton(choice: GameChoice) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(choice.emoji, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 60)
        button.backgroundColor = .white.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.tag = choice.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }
    
    func toggleGameControls(enabled: Bool) {
        rockButton.isEnabled = enabled
        paperButton.isEnabled = enabled
        scissorsButton.isEnabled = enabled
        UIView.animate(withDuration: 0.2) {
            self.rockButton.alpha = enabled ? 1.0 : 0.5
            self.paperButton.alpha = enabled ? 1.0 : 0.5
            self.scissorsButton.alpha = enabled ? 1.0 : 0.5
        }
    }
    
    func updateScoreLabel() {
        let modeText = (gameMode == .rounds) ? "Rondas" : "Puntos"
        scoreLabel.text = "\(modeText): \(currentScore)"
    }
    
    func showGameEndAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    enum GameMode {
        case rounds, points
    }
}
