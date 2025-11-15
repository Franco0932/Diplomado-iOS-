//
//  HomeView.swift
//  AppModulo
//
//  Created by Franco Ruiz on 08/11/25.
//

import UIKit

final class HomeView: UIView {
    lazy var imageType: UISwitch = {
        let UISwitch = UISwitch()
        return UISwitch
    }()
    
    lazy var captionSwitch = UISwitch()
    
    lazy var customTextSwitch = UISwitch()
    
    lazy var picsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pics", for: .normal)
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .accent
        configuration.baseBackgroundColor = .systemBackground
        button.configuration = configuration
        return button
    }()
    
    lazy var customTextField = UITextView()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setViewContainer()
        addConfigurationToContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return stackView
    }()
    
    private func createBasicLabel(text: String, useTAMIC: Bool) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = useTAMIC
        label.text = text
        return label
    }
    
    private func createHorizontalStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    
    private func createImageTypeConfiguration() -> UIStackView{
        let stackView = createHorizontalStack()
        let catLabel = createBasicLabel(text: "Cat", useTAMIC: false)
        catLabel.textAlignment = .center
        let dogLabel = createBasicLabel(text: "Dog", useTAMIC: false)
        dogLabel.textAlignment = .center
        stackView.addArrangedSubview(catLabel)
        stackView.addArrangedSubview(imageType)
        stackView.addArrangedSubview(dogLabel)
        dogLabel.widthAnchor.constraint(equalTo: catLabel.widthAnchor).isActive = true
        return stackView
    }
    
    private func creatCaptionConfiguration() -> UIStackView {
        let stackView = createHorizontalStack()
        stackView.addArrangedSubview(createBasicLabel(text: <#T##String#>, useTAMIC: <#T##Bool#>))
    }
    
    private func setViewContainer () {
        addSubview(stackViewContainer)
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    private func addConfigurationToContainer(){
        stackViewContainer.addArrangedSubview(createImageTypeConfiguration())
        stackViewContainer.addArrangedSubview(creatCaptionConfiguration())

    }
}
