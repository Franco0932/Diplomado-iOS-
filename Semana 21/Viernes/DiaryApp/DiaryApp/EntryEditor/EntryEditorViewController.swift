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
    
    // UI Elements
    private lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Título de tu recuerdo..."
        tf.font = .systemFont(ofSize: 20, weight: .semibold)
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var messageTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.layer.borderColor = UIColor.systemGray4.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 8
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var photoButton: UIButton = {
        var config = UIButton.Configuration.gray()
        config.image = UIImage(systemName: "camera.fill")
        config.title = " Foto"
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
        return btn
    }()
    
    private lazy var locationButton: UIButton = {
        var config = UIButton.Configuration.gray()
        config.image = UIImage(systemName: "mappin.and.ellipse")
        config.title = " Ubicación"
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(didTapLocation), for: .touchUpInside)
        return btn
    }()
    
    private lazy var previewImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .secondarySystemBackground
        iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.text = "Sin ubicación seleccionada"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    init(entry: DiaryEntry? = nil) {
        self.viewModel = EntryEditorViewModel(entry: entry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
        // Botón de guardar manual
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        
        // Observer para Guardado Automático (Borrador)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Editar Entrada"
        
        view.addSubview(titleTextField)
        view.addSubview(messageTextView)
        view.addSubview(buttonsStack)
        view.addSubview(locationLabel)
        view.addSubview(previewImageView)
        
        buttonsStack.addArrangedSubview(photoButton)
        buttonsStack.addArrangedSubview(locationButton)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonsStack.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            messageTextView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
            messageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            messageTextView.heightAnchor.constraint(equalToConstant: 150),
            
            previewImageView.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 16),
            previewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            previewImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func loadData() {
        titleTextField.text = viewModel.entry.title
        messageTextView.text = viewModel.entry.message
        
        if let image = viewModel.currentImage() {
            previewImageView.image = image
        }
        
        if let location = viewModel.entry.location {
            locationLabel.text = "📍 \(location.addressString ?? "Ubicación guardada")"
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapSave() {
        syncDataToViewModel()
        // Guardar como FINAL (no borrador)
        viewModel.saveEntry(asDraft: false)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func appWillResignActive() {
        syncDataToViewModel()
        // Guardar como BORRADOR automáticamente
        viewModel.saveEntry(asDraft: true)
        
        // Volvemos a la raiz para que al abrir de nuevo pida FaceID
        navigationController?.popToRootViewController(animated: false)
    }
    
    private func syncDataToViewModel() {
        viewModel.updateTitle(titleTextField.text ?? "")
        viewModel.updateMessage(messageTextView.text)
    }
    
    @objc private func didTapLocation() {
        let searchVC = LocationSearchViewController()
        searchVC.delegate = self
        let nav = UINavigationController(rootViewController: searchVC)
        present(nav, animated: true)
    }
    
    @objc private func didTapPhoto() {
        let alert = UIAlertController(title: "Seleccionar Foto", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { _ in
                self.openCamera()
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    private func openCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func openGallery() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - Image Delegates
extension EntryEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        
        viewModel.saveImage(image)
        previewImageView.image = image
    }
}

extension EntryEditorViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let self = self, let image = image as? UIImage, error == nil else { return }
            
            DispatchQueue.main.async {
                self.viewModel.saveImage(image)
                self.previewImageView.image = image
            }
        }
    }
}

// MARK: - Location Delegate
extension EntryEditorViewController: LocationSearchDelegate {
    func didSelectLocation(_ location: Location) {
        viewModel.updateLocation(location)
        locationLabel.text = "📍 \(location.addressString ?? "Ubicación seleccionada")"
    }
}
