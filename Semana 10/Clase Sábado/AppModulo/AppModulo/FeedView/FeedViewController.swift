//
//  FeedViewController.swift
//  AppModulo
//
//  Created by Franco Ruiz on 18/10/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var firstCaptionImageView: CaptionImageView!
    @IBOutlet weak var secondCaptionImageView: CaptionImageView!
    @IBOutlet weak var thirdCaptionImageView: CaptionImageView!
//    @IBOutlet weak var firstCaption: UILabel!
//    @IBOutlet weak var secondCaption: UILabel!
//    @IBOutlet weak var thirdCaption: UILabel!
    
    var pictureType: PictureType = .dog
    var showCaption: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        showOrHideCaption()
        setImagesAndCaptions()

    }
    
    private func showOrHideCaption(){
        firstCaptionImageView.isHidden = showCaption
        secondCaptionImageView.isHidden = showCaption
        thirdCaptionImageView.isHidden = showCaption
    }
    
    private func setImagesAndCaptions(){
        let captionedImage = pictureType.captionedImage
//        firstCaption.text = captionedImage[0].caption
//        secondCaption.text = captionedImage[1].caption
//        thirdCaption.text = captionedImage[2].caption
        firstCaptionImageView.captionedImage = captionedImage[0]
        secondCaptionImageView.captionedImage = captionedImage[1]
        thirdCaptionImageView.captionedImage = captionedImage[2]
    }
    
}
