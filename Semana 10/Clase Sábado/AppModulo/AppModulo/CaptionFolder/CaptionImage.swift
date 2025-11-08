//
//  CaptionImage.swift
//  AppModulo
//
//  Created by Franco Ruiz on 25/10/25.
//

import UIKit

final class CaptionImageView: UIView{
    
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var caption: UILabel!
    
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
        setUpViewWithBundle()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setUpViewWithBundle()
    }
    
    private func setUpViewWithBundle() {
        guard let contentView = Bundle.main.loadNibNamed("CaptionImage", owner: self)?.first as? UIView else { return }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false //Siempre hay que desactivarlo para hacer los contraints pre porgramados
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true //Hay que activar los constraints para que funcionen
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setUpViewWithNibInitialiaser(){
        guard let contentView = UINib(nibName: "CaptionImage", bundle: nil).instantiate(withOwner: self).first as? UIView else { return }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false //Siempre hay que desactivarlo para hacer los contraints pre porgramados
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true //Hay que activar los constraints para que funcionen
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
