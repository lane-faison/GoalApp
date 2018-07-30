//
//  UIColor+Extensions.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

public enum ColorTheme {
    case light
    case dark
}

extension UIColor {
    
    static var colorTheme: ColorTheme = UserDefaults.standard.bool(forKey: "darkThemed") ? .dark : .light
    
    static var primaryRed: UIColor = hexStringToUIColor(hex: "#F44336")
    static var primaryGreen: UIColor = hexStringToUIColor(hex: "#4CAF50")
    static var primaryLightGreen: UIColor = hexStringToUIColor(hex: "#8BC34A")
    static var primaryBlue: UIColor = hexStringToUIColor(hex: "#2196F3")
    static var primaryLightGray: UIColor = hexStringToUIColor(hex: "EFEFEF")
    static var primaryDarkGray: UIColor = hexStringToUIColor(hex: "444444")
    static var primaryBlack: UIColor = hexStringToUIColor(hex: "222222")
}

extension UIColor {
    
    static var primaryTextColor: UIColor {
        switch colorTheme {
        case .light:
            return primaryBlack
        case .dark:
            return primaryLightGray
        }
    }
    
    static var primaryBackgroundColor: UIColor {
        switch colorTheme {
        case .light:
            return .white
        case .dark:
            return primaryBlack
        }
    }
    
    static var sectionHeaderColor: UIColor {
        switch colorTheme {
        case .light:
            return primaryLightGray
        case .dark:
            return primaryDarkGray
        }
    }
}

extension UIColor {
    
    private static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
