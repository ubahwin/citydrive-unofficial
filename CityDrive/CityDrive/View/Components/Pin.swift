import SwiftUI
import MapKit

struct Pin: View {
    var color: Color = Color.green
    var frameHeight: CGFloat = 10
    var lineWidth: CGFloat = 2
    var shadowRadius: CGFloat = 1
    var strokeColor = Color.white

    var body: some View {
        Circle()
            .fill(color)
            .stroke(strokeColor, lineWidth: lineWidth)
            .frame(height: frameHeight)
            .shadow(radius: shadowRadius)
    }
}

class ImperativeMapPin: NSObject, Identifiable, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var image: UIImage?
    var frameHeight: CGFloat = 10
    var color: UIColor = .green

    init(title: String? = nil, coordinate: CLLocationCoordinate2D) {
        let circleSize = CGSize(width: frameHeight, height: frameHeight)
        let circleRect = CGRect(origin: .zero, size: circleSize)
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: circleRect)
        let greenCircleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.image = greenCircleImage
        self.title = title
        self.coordinate = coordinate
    }
}

#Preview {
    Pin(color: .green)
}
