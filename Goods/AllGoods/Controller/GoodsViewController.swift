//
//  ViewController.swift
//  Goods
//
//  Created by Данила on 24.08.2023.
//

import UIKit

class GoodsViewController: UIViewController, UITextFieldDelegate {

    var filteredData: [Advertisement?] = []
    var request = Request()
    var goods: [Advertisement?] = []
    var goodsView = GoodsView()
    var arrayLike: Array<Int> = UserDefaults.standard.array(forKey: "ArrayLikeKey") as? [Int] ?? []
    var searchTimer: Timer?
    var collectionView: UICollectionView?
    let imageCache = URLCache.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request.request { [weak self] values in
            DispatchQueue.main.async {
                self!.goods = values
                if values.isEmpty {
                    self!.showAlert(message: "Ошибка получения данных")
                } else {
                    self!.filteredData = values
                    self?.collectionView?.reloadData()
                }
            }
        }
        setUpCollectionView()
        setUpUI()
        view.backgroundColor = .background
        buttonsTarget()
        goodsView.searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        arrayLike = UserDefaults.standard.array(forKey: "ArrayLikeKey") as? [Int] ?? []
        collectionView?.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpUI() {
        view.addSubview(goodsView)
        goodsView.translatesAutoresizingMaskIntoConstraints = false
        if UIScreen.main.bounds.height < 730 {
            goodsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 27).isActive = true
        } else {
            goodsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 47).isActive = true
        }
        goodsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        goodsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        goodsView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: goodsView.bottomAnchor, constant: 20).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setUpCollectionView() {
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
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func buttonHeartTapped(_ sender: UIButton) {
        let goodViewController = FavoritesController()
        if let loadedArrayLike = UserDefaults.standard.array(forKey: "ArrayLikeKey") as? [Int] {
            goodViewController.favoritesId = loadedArrayLike
        }
        goodViewController.navigationControllerReference = navigationController
        navigationController?.pushViewController(goodViewController, animated: true)
    }
    @objc func buttonError(_ sender: UIButton) {
        self.viewDidLoad()
    }
    @objc func buttonSearchTapped(_ sender: UIButton) {
        goodsView.keyboardIsActive.toggle()
        if !goodsView.keyboardIsActive {
            goodsView.title.isHidden = true
            goodsView.buttonSearch.setImage(UIImage(systemName: "x.circle"), for: .normal)
            goodsView.heart.isHidden = true
            goodsView.searchTextField.becomeFirstResponder()
            goodsView.searchTextField.isHidden = false
        } else {
            goodsView.title.isHidden = false
            goodsView.heart.isHidden = false
            goodsView.searchTextField.isHidden = true
            goodsView.buttonSearch.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            view.endEditing(true)
//            goods = filteredData
            collectionView?.reloadData()
        }
    }
    
    private func buttonsTarget() {
        goodsView.buttonSearch.addTarget(self, action: #selector(buttonSearchTapped(_:)), for: .touchUpInside)
        goodsView.heart.addTarget(self, action: #selector(buttonHeartTapped(_:)), for: .touchUpInside)
    }
    
    func updateCollectionView(with searchText: String) {
        goods = filteredData.filter { $0!.title.lowercased().contains(searchText.lowercased()) }
        if searchText == "" { goods = filteredData }
        collectionView!.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            self?.updateCollectionView(with: textField.text ?? "")
        })
        return true
    }

}


extension GoodsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCell", for: indexPath) as! GoodCell
        if arrayLike.contains(indexPath.item) {
            cell.heartCell.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.heartCell.tintColor = .heartColor
        } else {
            cell.heartCell.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.heartCell.tintColor = .heartCellColor
        }
        cell.label.text = goods[indexPath.item]?.title
        cell.labelLocation.text = goods[indexPath.item]?.location
        cell.labelDate.text = goods[indexPath.item]?.createdDate
        cell.labelPrice.text = goods[indexPath.item]?.price
        if let imageUrl = URL(string: goods[indexPath.item]!.imageURL) {
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
        goodViewController.id = goods[indexPath.item]?.id
        goodViewController.navigationControllerReference = navigationController
        navigationController?.pushViewController(goodViewController, animated: true)
    }
}
