import Foundation
import SwiftUI

struct AppColor {
    static func green() -> Color {
        return Color(hex: 0x2fc25d)
    }

    static func green() -> UIColor {
        return UIColor(hex: 0x2fc25d)
    }

    static func purple() -> Color {
        return Color(hex: 0x8526ff)
    }

    static func purple() -> UIColor {
        return UIColor(hex: 0x8526ff)
    }

    static func red() -> Color {
        return Color(hex: 0xf53c2c)
    }

    static func red() -> UIColor {
        return UIColor(hex: 0xf53c2c)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

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
