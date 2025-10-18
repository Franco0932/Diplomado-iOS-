//
//  FeedViewController.swift
//  AppModulo
//
//  Created by Franco Ruiz on 18/10/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var firstCaption: UILabel!
    @IBOutlet weak var secondCaption: UILabel!
    @IBOutlet weak var thirdCaption: UILabel!
    
    var pictureType: PictureType = .dog
    var showCaption: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        showOrHideCaption()
        setImagesAndCaptions()

    }
    
    private func showOrHideCaption(){
        firstCaption.isHidden = !showCaption
        secondCaption.isHidden = !showCaption
        thirdCaption.isHidden = !showCaption
    }
    
    private func setImagesAndCaptions(){
        let captionedImage = pictureType.captionedImage
        firstCaption.text = captionedImage[0].caption
        secondCaption.text = captionedImage[1].caption
        thirdCaption.text = captionedImage[2].caption
        firstImageView.image = captionedImage[0].image
        secondImageView.image = captionedImage[1].image
        thirdImageView.image = captionedImage[2].image
    }
    
}
