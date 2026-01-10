//
//  ColoursModel.swift
//  AppModulo
//
//  Created by Franco Ruiz on 29/11/25.
//

import UIKit

class ColoursModel {
    
    private let repository: ColoursRepository
    private let imageDownloads: ImageDowloaderProtocol
    
    var colours = [Colour]()
    private var currentOffSet: Int = 0
    
    init(repository: ColoursRepository, imageDownloads: ImageDowloaderProtocol, colours: [Colour] = [Colour](), currentOffSet: Int) {
        self.repository = repository
        self.imageDownloads = imageDownloads
        self.colours = colours
        self.currentOffSet = 0
    }
    
    func loadColourList(handler: @escaping (Error?) -> Void) {
        do {
            if let ColoursDTO = try repository.getColoursList(for: "") {
                self.colours = ColoursDTO.compactMap({ dto in
                    var urlComponents = URLComponents(string: dto.url)
                    urlComponents?.host = "dummyImage.com"
                    guard let url = URLComponents?.url else { return nil}
                    return Colour(url: url)
                })
            }
            handler(nil)
        }catch{
            handler(error)
        }
    }
}

class Colour {
    let url: URL
    var image: UIImage?
    
    init(url: URL, image: UIImage? = nil) {
        self.url = url
        self.image = image
    }
    
    func downloadColour() {
        guard let data = imageDownloads.downloadImage(url: url) else {return}
    }
    
}

protocol ImageDowloaderProtocol {
    func downloadImage(url: URL) -> Data?
}

struct LocalImageDowloader: ImageDowloaderProtocol {
    func downloadImage(url: URL) -> Data? {
        UIImage.dog1.jpegData(compressionQuality: 1)
    }
}
