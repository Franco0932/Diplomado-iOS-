//
//  CaptionImage.swift
//  AppModulo
//
//  Created by Franco Ruiz on 25/10/25.
//

import UIKit

final class captionImageView: UIView{
    
//    @IBOutlet private var image: UIImageView!
//    @IBOutlet private var caption: UILabel!
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var caption: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    var showCaption: Bool = false{
        didSet {
            caption.isHidden = !showCaption
        }
    }
    
    var captionedImage: CaptionedImage? {
        didSet {
            caption.text = captionedImage?.caption
            image.image = captionedImage?.image
        }
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setStackViewContainer()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setStackViewContainer()
    }
    
    private func setStackViewContainer(){
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(caption)
    }
    
//    private func setUpViewWithBundle() {
//        guard let contentView = Bundle.main.loadNibNamed("CaptionImage", owner: self)?.first as? UIView else { return }
//        addSubview(contentView)
//        contentView.translatesAutoresizingMaskIntoConstraints = false //Siempre hay que desactivarlo para hacer los contraints pre porgramados
//        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true //Hay que activar los constraints para que funcionen
//        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//    
//    private func setUpViewWithNibInitialiaser(){
//        guard let contentView = UINib(nibName: "CaptionImage", bundle: nil).instantiate(withOwner: self).first as? UIView else { return }
//        addSubview(contentView)
//        contentView.translatesAutoresizingMaskIntoConstraints = false //Siempre hay que desactivarlo para hacer los contraints pre porgramados
//        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true //Hay que activar los constraints para que funcionen
//        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
    
}
