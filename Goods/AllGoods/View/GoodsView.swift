//
//  GoodsView.swift
//  Goods
//
//  Created by Данила on 24.08.2023.
//

import Foundation
import UIKit

class GoodsView: UIView {
    
    var keyboardIsActive: Bool = false
        
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Все товары"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название товара"
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var buttonSearch: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .searchButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var heart: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .heartColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setUpConstait() {
        addSubview(buttonSearch)
        addSubview(title)
        addSubview(heart)
        addSubview(searchTextField)
        buttonSearch.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        buttonSearch.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: buttonSearch.centerYAnchor).isActive = true
        heart.centerYAnchor.constraint(equalTo: buttonSearch.centerYAnchor).isActive = true
        heart.trailingAnchor.constraint(equalTo: buttonSearch.leadingAnchor, constant: -12).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: buttonSearch.centerYAnchor).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstait()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
