//
//  MyColors.swift
//  PokerMemorina
//
//  Created by .
//

import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(hex: Int) {
       self.init(
           red: (hex >> 16) & 0xFF,
           green: (hex >> 8) & 0xFF,
           blue: hex & 0xFF
       )
   }
}

enum MyColors: Int, CaseIterable {
    case orange = 0xFF7F00
    case black = 0x000000
    case lightBlue = 0x99DDFF
    case white = 0xFFFFFF
    case tint = 0xEE5916
    case secondary = 0xF7AC8B
    case blue = 0x019AE6
    case background = 0xFFA14A
    case darkGreen = 0x4E5C5F
    case darkBlue = 0x121826
    case secondaryText = 0xAEAEAE
    case green = 0x39D036
    case tab = 0x000001
    
    var color: UIColor {
        
        switch self {
        default:
            return UIColor.init(hex: rawValue)
        }
        
    }
}

