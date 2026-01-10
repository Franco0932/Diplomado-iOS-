//
//  ColoursModel.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import UIKit

class ColoursModel {
    
    private let repository: ColoursRepository
    private let imageDownloader: ImageDownloaderProtocol
    
    var colours = [Colour]()
    private var currentOffset: Int = 0
    
    init(repository: ColoursRepository, imageDownloader: ImageDownloaderProtocol) {
        self.repository = repository
        self.imageDownloader = imageDownloader
        self.colours = []
        self.currentOffset = 0
    }
    
    func loadColoursList(handler: @escaping (Error?) -> Void) {
        repository.getColourList(for: "") { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let coloursDTO):
                self.colours = coloursDTO?.compactMap({ dto in
                    var urlComponents = URLComponents(string: dto.url)
                    urlComponents?.host = "dummyimage.com"
                    guard let url = urlComponents?.url else { return nil }
                    return Colour(url: url, downloader: self.imageDownloader)
                }) ?? []
                handler(nil)
            case .failure(let failure):
                handler(failure)
            }
        }
    }
    
    func loadColourList() async throws {
        let colours = try await repository.getColourList(for: "")
        self.colours = colours?.compactMap 
    }
    
//    func loadColoursList(handler: @escaping (Error?) -> Void) {
//        do {
//            if let coloursDTO = try repository.getColourList(for: "") {
//                colours = coloursDTO.compactMap({ dto in
//                    var urlComponents = URLComponents(string: dto.url)
//                    urlComponents?.host = "dummyimage.com"
//                    guard let url = urlComponents?.url else { return nil }
//                    return Colour(url: url, downloader: imageDownloader)
//                })
//            }
//            handler(nil)
//        } catch {
//            handler(error)
//        }
//    }
    
}

class Colour {
    private let imageDownloader: ImageDownloaderProtocol
    
    let url: URL
    var image: UIImage?
    
    init(url: URL, downloader: ImageDownloaderProtocol, image: UIImage? = nil) {
        self.url = url
        self.image = image
        self.imageDownloader = downloader
    }
    
    func downloadColour(handler: @escaping (UIImage?) -> Void) {
        imageDownloader.downloadImage(url: url) { [weak self] data in
            guard let data else {
                handler(nil)
                return
            }
            let image = UIImage(data: data)
            self?.image = image
            handler(image)
        }
    }
}
protocol ImageDownloaderProtocol {
    func downloadImage(url: URL) -> Data?
    func downloadImage(url: URL, handler: @escaping (Data?) -> Void)
}

struct LocalImageDownloader: ImageDownloaderProtocol {
    
    func downloadImage(url: URL) -> Data? {
        UIImage.dog1.jpegData(compressionQuality: 1)
    }
    
    func downloadImage(url: URL, handler: @escaping (Data?) -> Void) {
        handler(UIImage.dog1.jpegData(compressionQuality: 1))
    }
    
}
