//
//  Extensions.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 15.03.23.
//

import Foundation
import UIKit

internal extension String{
    func localized() -> Self{
        return NSLocalizedString(self, comment: "")
    }
}

internal extension NSObject {
    static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

internal extension UITableViewCell {
    static var identifier: String {
        self.nameOfClass
    }
}

internal extension UITableView {
    func registerCell<T: UITableViewCell>(cell: T.Type) {
        self.register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func dequeueCell<T: UITableViewCell>(cell: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cell.identifier) as? T
    }
}

internal extension UIColor{
    convenience init(hexString: String) {
            let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            
            if hexString.hasPrefix("#") {
                scanner.scanLocation = 1
            }
            
            var color: UInt32 = 0
            scanner.scanHexInt32(&color)
            
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1)
        }
        
        var hexString: String {
            
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            
            getRed(&r, green: &g, blue: &b, alpha: &a)
            
            let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
            
            return String(format: "#%06x", rgb)
        }
}

internal extension [String : String]{
    var light: UIColor{
        return UIColor(hexString: self["light"]!)
    }
    
    var dark: UIColor{
        return UIColor(hexString: self["dark"]!)
    }
}
