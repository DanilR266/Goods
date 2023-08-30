//
//  Extension+Color.swift
//  Goods
//
//  Created by Данила on 24.08.2023.
//

import Foundation
import UIKit

extension UIColor {
    static var heartColor: UIColor { return UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1) }
    static var cellColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 0.07) : UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07)
        })
    }
    static var cellLikeColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1) : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        })
    }
    static var searchButtonColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1) : UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        })
    }
    static var subTextColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1) : UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        })
    }
    static var heartSubColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1) : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        })
    }
    static var heartCellColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1) : UIColor(red: 191/255, green: 194/255, blue: 200/255, alpha: 0.4)
        })
    }
    static var background: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1) : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        })
    }
    static var textColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) : UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        })
    }
    static var selectedTextColor: UIColor {
        return UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5) : UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        })
    }
}

