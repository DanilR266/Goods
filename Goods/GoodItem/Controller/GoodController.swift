//
//  GoodController.swift
//  Goods
//
//  Created by Данила on 25.08.2023.
//

import Foundation
import UIKit

class GoodController: UIViewController {

    var goodView = GoodView()
    var goodInfo: WelcomeGood?
    var request = RequestGood()
    var id: String?
    var arrayLike: Array<Int> = UserDefaults.standard.array(forKey: "ArrayLikeKey") as? [Int] ?? []
    var image: UIImage?
    var navigationControllerReference: UINavigationController?
    let backButton = UIButton(type: .custom)
    var scrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request.request(id: self.id ?? "0") { [weak self] value in
            self?.goodInfo = value
            DispatchQueue.main.async {
                if value == nil {
                    self?.showAlert(message: "Ошибка получения данных")
                } else {
                    self?.setData()
                }
            }
        }
        view.backgroundColor = .background
        setUpUI()
        buttonsTarget()
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
    }
    
    private func animateViewCopy() {
        UIView.animate(withDuration: 0.7, animations: {
            self.goodView.copyView.alpha = 1
         }, completion: { (value: Bool) in
             UIView.animate(withDuration: 0.7, delay: 2, animations: {
                 self.goodView.copyView.alpha = 0
             })
         })
    }
    
    @objc private func likeButtonTapped() {
        arrayLike.append(Int(id!)!-1)
        animateViewCopy()
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.arrayLike, forKey: "ArrayLikeKey")
        }
    }
    
    @objc func phoneButtonTapped() {
        let phoneNumber = goodInfo?.phoneNumber
        let alert = UIAlertController(title: "Позвонить", message: phoneNumber, preferredStyle: .alert)
        let callAction = UIAlertAction(title: "Позвонить", style: .default) { _ in
            if let url = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(callAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    @objc func emailButtonTapped() {
        if let email = goodInfo?.email, let subject = goodInfo?.title {
            let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let emailURLString = "mailto:\(email)?subject=\(encodedSubject)"
            if let emailURL = URL(string: emailURLString) {
                if UIApplication.shared.canOpenURL(emailURL) {
                    UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                } else {
                    let alertController = UIAlertController(
                        title: "Ошибка",
                        message: "Не удается открыть приложение 'Почта'",
                        preferredStyle: .alert
                    )
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    let copyAction = UIAlertAction(title: "Скопировать email", style: .default) {_ in
                        UIPasteboard.general.string = self.goodInfo?.email
                    }
                    alertController.addAction(copyAction)
                    present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func buttonsTarget() {
        goodView.like.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        goodView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        goodView.phone.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        goodView.email.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
    }
    
    private func setData() {
        self.goodView.label.text = self.goodInfo?.title
        self.goodView.labelDescription.text = self.goodInfo?.description
        self.goodView.price.text = self.goodInfo?.price
        self.goodView.location.text = "\(self.goodInfo!.location)\n\(self.goodInfo!.address)"
        self.goodView.phone.setTitle(self.goodInfo?.phoneNumber, for: .normal)
        self.goodView.phone.isEnabled = true
        self.goodView.email.setTitle(self.goodInfo?.email, for: .normal)
        self.goodView.email.isEnabled = true
        self.goodView.date.text = self.goodInfo?.createdDate
        let url = URL(string: self.goodInfo?.imageURL ?? "")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.goodView.image.image = UIImage(data: data ?? Data()) ?? nil
            }
        }
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
    
    @objc private func backButtonTapped() {
        navigationControllerReference?.popViewController(animated: true)
    }
    
}
