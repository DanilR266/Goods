//
//  FavoritesView.swift
//  Goods
//
//  Created by Данила on 27.08.2023.
//

import Foundation
import UIKit

class FavoritesView: UIView {
    
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
    
    lazy var delete: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить избранное", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(UIColor.textColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setUpConstraints() {
        addSubview(delete)
        delete.topAnchor.constraint(equalTo: topAnchor).isActive = true
        delete.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
