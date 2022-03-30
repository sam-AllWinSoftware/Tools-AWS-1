import UIKit
import SwiftUI

enum ThemeFactory {
    
    static func font(_ sunFont: SunFont) -> UIFont? {
        return sunFont.font
    }

    static func color(_ themeColor: SunColor) -> UIColor? {
        return themeColor.color
    }
    
    static func color(_ themeColor: SunColor) -> CGColor? {
        return color(themeColor)?.cgColor
    }
}
