//
//  Ex-UIFont.swift
//
//
//  Created by .
//

import UIKit

//MARK: - UIFont -
enum CommonsFontType: String {
    case black = "Black"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    case thin = "Thin"
    case inter = "Inter"
    
    public func font(size: CGFloat) -> UIFont? {
        return UIFont(name: "SFPro-" + self.rawValue, size: size)
    }
}
