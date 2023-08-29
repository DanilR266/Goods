//
//  GoodController.swift
//  Goods
//
//  Created by Данила on 25.08.2023.
//

import Foundation
import UIKit
import Network

class GoodController: UIViewController {
    
    var id: String?
    var arrayLike: Array<Int> = UserDefaults.standard.array(forKey: "ArrayLikeKey") as? [Int] ?? []
    var goodView = GoodView()
    var goodInfo: WelcomeGood?
    var request = RequestGood()
    var image: UIImage?
    var navigationControllerReference: UINavigationController?
    let backButton = UIButton(type: .custom)
    var scrollView = UIScrollView()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.request.request(id: self.id ?? "0") { [weak self] value in
                    self?.goodInfo = value
                    DispatchQueue.main.async {
                        self?.goodView.label.text = self?.goodInfo?.title
                        self?.goodView.labelDescription.text = self?.goodInfo?.description
                        self?.goodView.price.text = self?.goodInfo?.price
                        self?.goodView.location.text = "\(self!.goodInfo!.location)\n\(self!.goodInfo!.address)"
                        self?.goodView.phone.text = self?.goodInfo?.phoneNumber
                        self?.goodView.email.text = self?.goodInfo?.email
                        self?.goodView.date.text = self?.goodInfo?.createdDate
                        let url = URL(string: self?.goodInfo?.imageURL ?? "")
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            DispatchQueue.main.async {
                                self?.goodView.image.image = UIImage(data: data ?? Data()) ?? nil
                            }
                        }
                        self?.goodView.setNeedsDisplay()
                    }
                }
            }
        }
        view.backgroundColor = .background
        goodView.like.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        setUpUI()
        goodView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let customBackButton = UIBarButtonItem(customView: goodView.backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    override func viewDidAppear(_ animated: Bool) {
        if UIScreen.main.bounds.height >= 730.0 {
            scrollView.isScrollEnabled = false
        }
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 730)
    }
    
    private func setUpUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.addSubview(goodView)
        goodView.translatesAutoresizingMaskIntoConstraints = false
        goodView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        goodView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        goodView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        goodView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        goodView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
//        goodView.bottomAnchor.constraint(equalTo:  scrollView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    @objc private func likeButtonTapped() {
        arrayLike.append(Int(id!)!-1)
        print(arrayLike)
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.arrayLike, forKey: "ArrayLikeKey")
        }
    }
    
    @objc private func backButtonTapped() {
        navigationControllerReference?.popViewController(animated: true)
    }
    
}
