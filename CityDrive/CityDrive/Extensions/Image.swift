import Foundation
import UIKit

extension UIImage {
    func resizePin(height: CGFloat) -> UIImage {
        let size = CGSize(width: height, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }

    static func drawPin(color: UIColor) -> UIImage {
        let circleSize: CGFloat = 100
        let circleInset: CGFloat = 20
        let shadowOffset: CGFloat = 10

        let totalSize = circleSize + 2 * (circleInset + shadowOffset)
        let rect = CGRect(
            x: 0,
            y: 0,
            width: totalSize,
            height: totalSize
        )

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()

        let whiteCircleRect = CGRect(
            x: shadowOffset,
            y: shadowOffset,
            width: circleSize,
            height: circleSize
        )

        let greenCircleRect = CGRect(
            x: shadowOffset + circleInset,
            y: shadowOffset + circleInset,
            width: circleSize - 2 * circleInset,
            height: circleSize - 2 * circleInset
        )

        context?.setShadow(
            offset: CGSize(width: shadowOffset, height: shadowOffset),
            blur: 0.2,
            color: UIColor.gray.cgColor
        )
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillEllipse(in: whiteCircleRect)

        context?.setShadow(offset: CGSize.zero, blur: 0, color: nil)

        context?.setFillColor(color.cgColor)
        context?.fillEllipse(in: greenCircleRect)

        let image = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        return image
    }
}
