//
//  EntryEditorViewController.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit
import PhotosUI

class EntryEditorViewController: UIViewController {
    
    private let viewModel: EntryEditorViewModel
    
    private let stackView = UIStackView()
    private let titleField = UITextField()
    private let messageView = UITextView()
    private let photoButton = UIButton(type: .system)
    private let locationButton = UIButton(type: .system)
    private let imageView = UIImageView()
    private let locationLabel = UILabel()
    
    init(entry: DiaryEntry? = nil) {
        self.viewModel = EntryEditorViewModel(entry: entry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Editar"
        
        setupUI()
        loadData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveDraft), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    private func setupUI() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        titleField.placeholder = "Titulo"
        titleField.borderStyle = .roundedRect
        
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        photoButton.setTitle("Foto", for: .normal)
        photoButton.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        
        locationButton.setTitle("Ubicacion", for: .normal)
        locationButton.addTarget(self, action: #selector(pickLocation), for: .touchUpInside)
        
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.backgroundColor = .secondarySystemBackground
        
        locationLabel.textColor = .gray
        locationLabel.font = .systemFont(ofSize: 12)
        
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(messageView)
        stackView.addArrangedSubview(photoButton)
        stackView.addArrangedSubview(locationButton)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(imageView)
    }
    
    private func loadData() {
        titleField.text = viewModel.entry.title
        messageView.text = viewModel.entry.message
        imageView.image = viewModel.currentImage()
        if let loc = viewModel.entry.location {
            locationLabel.text = loc.addressString
        }
    }
    
    @objc private func save() {
        updateViewModel()
        viewModel.saveEntry(asDraft: false)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveDraft() {
        updateViewModel()
        viewModel.saveEntry(asDraft: true)
        navigationController?.popToRootViewController(animated: false)
    }
    
    private func updateViewModel() {
        viewModel.updateTitle(titleField.text ?? "")
        viewModel.updateMessage(messageView.text ?? "")
    }
    
    @objc private func pickLocation() {
        let vc = LocationSearchViewController()
        vc.delegate = self
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func pickPhoto() {
        let alert = UIAlertController(title: "Imagen", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camara", style: .default) { _ in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default) { _ in
            var config = PHPickerConfiguration()
            config.filter = .images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            self.present(picker, animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
}

extension EntryEditorViewController: LocationSearchDelegate {
    func didSelectLocation(_ location: Location) {
        viewModel.updateLocation(location)
        locationLabel.text = location.addressString
    }
}

extension EntryEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let img = info[.originalImage] as? UIImage {
            viewModel.saveImage(img)
            imageView.image = img
        }
    }
}

extension EntryEditorViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.first?.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] img, _ in
            guard let image = img as? UIImage else { return }
            DispatchQueue.main.async {
                self?.viewModel.saveImage(image)
                self?.imageView.image = image
            }
        }
    }
}
