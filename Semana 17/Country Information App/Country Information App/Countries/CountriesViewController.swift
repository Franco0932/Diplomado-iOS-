//
//  CountriesViewController.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import UIKit

class CountriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var countries: [CountryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Paises"
        view.backgroundColor = .systemBackground
        countries = DataManager.shared.countries
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: "CountryCell")
        view.addSubview(collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let country = countries[indexPath.item]
        cell.configure(name: country.name, imageName: country.flagImageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = CountryDetailViewController()
        detailVC.country = countries[indexPath.item]
        
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
