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
}
