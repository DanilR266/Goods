//
//  Favorites.swift
//  Goods
//
//  Created by Данила on 27.08.2023.
//

import Foundation
import UIKit


class FavoritesController: UIViewController {
    
    let imageCache = URLCache.shared
    var favoritesId: [Int] = []
    var favorites: [Advertisement?] = []
    var collectionView: UICollectionView?
    var request = RequestFavorites()
    var navigationControllerReference: UINavigationController?
    var favoritesView = FavoritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        request.request(array: favoritesId) { [weak self] values in
            DispatchQueue.main.async {
                self!.favorites = values
                self!.collectionView?.reloadData()
                print(values.count)
            }
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 25
        layout.itemSize = CGSize(width: 158, height: 220)
                
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(GoodCell.self, forCellWithReuseIdentifier: "GoodCell")
        collectionView?.backgroundColor = .background
               
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.isPrefetchingEnabled = false
        
        view.addSubview(collectionView ?? UICollectionView())
        setUpUI()
        favoritesView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let customBackButton = UIBarButtonItem(customView: favoritesView.backButton)
        navigationItem.leftBarButtonItem = customBackButton
        favoritesView.delete.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setUpUI() {
        view.addSubview(favoritesView)
        favoritesView.translatesAutoresizingMaskIntoConstraints = false
        if UIScreen.main.bounds.height < 730 {
            favoritesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        } else {
            favoritesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        }
        favoritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        favoritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        favoritesView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: favoritesView.bottomAnchor, constant: 10).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    @objc private func backButtonTapped() {
        navigationControllerReference?.popViewController(animated: true)
    }
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let empty: [Int] = []
        DispatchQueue.main.async {
            UserDefaults.standard.set(empty, forKey: "ArrayLikeKey")
        }
        favorites = []
        collectionView?.reloadData()
    }
    
}

extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCell", for: indexPath) as! GoodCell
        cell.label.text = favorites[indexPath.item]?.title
        cell.labelLocation.text = favorites[indexPath.item]?.location
        cell.labelDate.text = favorites[indexPath.item]?.createdDate
        cell.labelPrice.text = favorites[indexPath.item]?.price
        cell.heartCell.isEnabled = false
        cell.heartCell.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.heartCell.tintColor = .heartColor
        if let imageUrl = URL(string: favorites[indexPath.item]!.imageURL) {
            if let cachedResponse = imageCache.cachedResponse(for: URLRequest(url: imageUrl)) {
                if let image = UIImage(data: cachedResponse.data) {
                    cell.image.image = image
                }
            } else {
                URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        let cachedResponse = CachedURLResponse(response: response!, data: data)
                        self.imageCache.storeCachedResponse(cachedResponse, for: URLRequest(url: imageUrl))
                        DispatchQueue.main.async {
                            cell.image.image = image
                        }
                    }
                }.resume()
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goodViewController = GoodController()
        goodViewController.id = favorites[indexPath.item]?.id
        goodViewController.navigationControllerReference = navigationController
        navigationController?.pushViewController(goodViewController, animated: true)
    }
}
