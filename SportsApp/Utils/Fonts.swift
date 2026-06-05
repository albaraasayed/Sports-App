//
//  Fonts.swift
//  SportsApp
//
//  Created by albaraa alsayed on 06/12/1447 AH.
//

import UIKit

enum BebasWeight: String {
    case thin = "BebasNeue-Thin"
    case light = "BebasNeue-Light"
    case book = "BebasNeue-Book"
    case regular = "BebasNeue-Regular"
    case bold = "BebasNeue-Bold"
}

enum ManropeWeight: String {
    case thin = "Manrope-Thin"
    case light = "Manrope-Light"
    case regular = "Manrope-Regular"
    case medium = "Manrope-Medium"
    case semiBold = "Manrope-SemiBold"
    case bold = "Manrope-Bold"
}

extension UIFont {
    
    static func bebas(weight: BebasWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func manrope(weight: ManropeWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
