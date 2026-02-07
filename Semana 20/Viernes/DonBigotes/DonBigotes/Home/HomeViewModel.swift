//
//  HomeViewModel.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation

class HomeViewModel {
    private let dataFileName = "don_bigotes"
    private var storeData: Store?
    
    var storeName: String { storeData?.name ?? "" }
    var storeSlogan: String { storeData?.slogan ?? "" }
    var storeDescription: String { storeData?.description ?? "" }
    var logoURL: String { storeData?.logoURL ?? "" }
    
    var branches: [Branch] { storeData?.branches ?? [] }
    
    init() {
        loadData()
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: dataFileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedData = try? JSONDecoder().decode(StoreData.self, from: data)
        else {
            print("Error cargando JSON")
            return
        }
        
        self.storeData = decodedData.store
    }
}

