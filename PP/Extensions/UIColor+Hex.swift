//
//  UIColor+Hex.swift
//  PP
//
//  Created by Максим Храбрый on 11.03.2021.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
