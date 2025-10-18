//
//  PictureType.swift
//  AppModulo
//
//  Created by Franco Ruiz on 18/10/25.
//

import Foundation
import UIKit

enum PictureType{
    case dog, cat
    
    var captionedImage: [(image: UIImage, caption: String)] {
        switch self {
        case .dog:
            return [
                (UIImage.dog1, "Peluzo"),
                (UIImage(resource: .dog2), "Fido"),
                (UIImage(named: "dog-3") ?? UIImage(), "Milaneso")
            ]
        case .cat:
            return [
                (UIImage.cat1, "Milo"),
                (UIImage.cat2, "Coffee"),
                (UIImage.cat3, "Marcelo"),
                ]
        }
    }
}
