//
//  ErrorView.swift
//  Goods
//
//  Created by Данила on 29.08.2023.
//

import Foundation
import UIKit

class ErrorView: UIView {
    
    lazy var title: UIButton = {
        let label = UIButton()
        label.setTitle("Ошибка интернет соединения", for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        label.setTitleColor(UIColor.textColor, for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpConstait() {
        addSubview(title)
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstait()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
