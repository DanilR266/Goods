//
//  GoodController.swift
//  Goods
//
//  Created by Данила on 25.08.2023.
//

import Foundation
import UIKit

class GoodController: UIViewController {
    
    var id: String?
    var goodView = GoodView()
    var goodInfo: WelcomeGood?
    var request = RequestGood()
    var image: UIImage?
    var navigationControllerReference: UINavigationController?
    let backButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        request.request(id: id ?? "0") { [weak self] value in
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
        view.backgroundColor = .background
        super.viewDidLoad()
        setUpUI()
        goodView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let customBackButton = UIBarButtonItem(customView: goodView.backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    private func setUpUI() {
        view.addSubview(goodView)
        goodView.translatesAutoresizingMaskIntoConstraints = false
        goodView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20).isActive = true
        goodView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        goodView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        goodView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func backButtonTapped() {
        print("BackButton")
        navigationControllerReference?.popViewController(animated: true)
    }
    
}
