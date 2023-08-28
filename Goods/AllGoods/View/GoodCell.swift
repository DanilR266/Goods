//
//  GoodCell.swift
//  Goods
//
//  Created by Данила on 24.08.2023.
//

import Foundation
import UIKit

class GoodCell: UICollectionViewCell {
    
    var selectedHeart: Bool = false
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Load"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var labelLocation: UILabel = {
        let label = UILabel()
        label.text = "Load"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .subTextColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var labelDate: UILabel = {
        let label = UILabel()
        label.text = "Load"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .subTextColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var labelPrice: UILabel = {
        let label = UILabel()
        label.text = "Load"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var heartSubView: UIView = {
        let view = UIButton()
        view.backgroundColor = .heartSubColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var heartCell: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(heartButtonAction), for: .touchUpInside)
        button.tintColor = .heartCellColor
        return button
    }()
    lazy var heartInCell: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    var heartButtonTapped: (() -> Void)?
    
    @objc private func heartButtonAction() {
        selectedHeart = !selectedHeart
        heartButtonTapped?()
        if selectedHeart {
            heartCell.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartCell.tintColor = .heartColor
        } else {
            heartCell.setImage(UIImage(systemName: "heart"), for: .normal)
            heartCell.tintColor = .heartCellColor
        }
    }
    
    func setUpUI() {
        self.addSubview(label)
        self.addSubview(image)
        self.addSubview(labelLocation)
        self.addSubview(labelDate)
        self.addSubview(labelPrice)
        self.addSubview(heartSubView)
        
        image.widthAnchor.constraint(equalToConstant: 136).isActive = true
        image.heightAnchor.constraint(equalToConstant: 97).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 9).isActive = true
        
        label.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: image.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        
        labelPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9).isActive = true
        labelPrice.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        labelPrice.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        labelDate.bottomAnchor.constraint(equalTo: labelPrice.topAnchor, constant: -12).isActive = true
        labelDate.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        labelDate.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        labelLocation.bottomAnchor.constraint(equalTo: labelDate.topAnchor, constant: -3).isActive = true
        labelLocation.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        labelLocation.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        heartSubView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        heartSubView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        heartSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9).isActive = true
        heartSubView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9).isActive = true
        heartSubView.addSubview(heartCell)
        heartCell.centerYAnchor.constraint(equalTo: heartSubView.centerYAnchor).isActive = true
        heartCell.centerXAnchor.constraint(equalTo: heartSubView.centerXAnchor).isActive = true
        heartCell.widthAnchor.constraint(equalToConstant: 22).isActive = true
        heartCell.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .cellColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        setUpUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
