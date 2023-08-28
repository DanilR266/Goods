//
//  GoodView.swift
//  Goods
//
//  Created by Данила on 25.08.2023.
//

import Foundation
import UIKit


class GoodView: UIView {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("  Все товары", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(UIColor.textColor, for: .normal)
        var configuration = button.configuration
        configuration?.titlePadding = 10
        button.configuration = configuration
        return button
    }()

    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "load")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .subTextColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var price: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .textColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var location: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var phone: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var email: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .subTextColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconLocation: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        if let phoneImage = UIImage(named: "Location") {
            if #available(iOS 13.0, *) {
                let userInterfaceStyle = traitCollection.userInterfaceStyle
                if userInterfaceStyle == .dark, let darkPhoneImage = UIImage(named: "LocationDark") {
                    imageView.image = darkPhoneImage
                } else {
                    imageView.image = phoneImage
                }
            } else {
                imageView.image = phoneImage
            }
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var iconPhone: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        if let phoneImage = UIImage(named: "Call") {
            if #available(iOS 13.0, *) {
                let userInterfaceStyle = traitCollection.userInterfaceStyle
                if userInterfaceStyle == .dark, let darkPhoneImage = UIImage(named: "CallDark") {
                    imageView.image = darkPhoneImage
                } else {
                    imageView.image = phoneImage
                }
            } else {
                imageView.image = phoneImage
            }
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var iconMessage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
        if let phoneImage = UIImage(named: "Message") {
            if #available(iOS 13.0, *) {
                let userInterfaceStyle = traitCollection.userInterfaceStyle
                if userInterfaceStyle == .dark, let darkPhoneImage = UIImage(named: "MessageDark") {
                    imageView.image = darkPhoneImage
                } else {
                    imageView.image = phoneImage
                }
            } else {
                imageView.image = phoneImage
            }
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setUpConstait() {
        addSubview(label)
        addSubview(image)
        addSubview(labelDescription)
        addSubview(rectangleView)
        addSubview(date)
        image.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        image.heightAnchor.constraint(equalToConstant: 295).isActive = true
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        labelDescription.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        rectangleView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        rectangleView.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16).isActive = true
        rectangleView.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        rectangleView.addSubview(price)
        price.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor).isActive = true
        price.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        setUpIcons()
        date.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        date.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 28).isActive = true
    }
    
    private func setUpIcons() {
        addSubview(iconLocation)
        addSubview(iconPhone)
        addSubview(iconMessage)
        iconLocation.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 30).isActive = true
        iconLocation.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        iconPhone.topAnchor.constraint(equalTo: iconLocation.bottomAnchor, constant: 23).isActive = true
        iconPhone.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        iconMessage.topAnchor.constraint(equalTo: iconPhone.bottomAnchor, constant: 30).isActive = true
        iconMessage.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        addSubview(location)
        addSubview(phone)
        addSubview(email)
        location.centerYAnchor.constraint(equalTo: iconLocation.centerYAnchor).isActive = true
        location.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 67).isActive = true
        phone.centerYAnchor.constraint(equalTo: iconPhone.centerYAnchor).isActive = true
        phone.leadingAnchor.constraint(equalTo: location.leadingAnchor).isActive = true
        email.centerYAnchor.constraint(equalTo: iconMessage.centerYAnchor).isActive = true
        email.leadingAnchor.constraint(equalTo: location.leadingAnchor).isActive = true
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if let phoneImage = UIImage(named: "Call") {
                let userInterfaceStyle = traitCollection.userInterfaceStyle
                if userInterfaceStyle == .dark, let darkPhoneImage = UIImage(named: "CallDark") {
                    iconPhone.image = darkPhoneImage
                } else {
                    iconPhone.image = phoneImage
                }
            }
            
            if let locationImage = UIImage(named: "Location") {
                let userInterfaceStyle = traitCollection.userInterfaceStyle
                if userInterfaceStyle == .dark, let darkLocationImage = UIImage(named: "LocationDark") {
                    iconLocation.image = darkLocationImage
                } else {
                    iconLocation.image = locationImage
                }
            }
            
            if let messageImage = UIImage(named: "Message") {
                let userInterfaceStyle = traitCollection.userInterfaceStyle
                if userInterfaceStyle == .dark, let darkMessageImage = UIImage(named: "MessageDark") {
                    iconMessage.image = darkMessageImage
                } else {
                    iconMessage.image = messageImage
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setUpConstait()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
