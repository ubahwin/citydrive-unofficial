import SwiftUI
import MapKit

struct Pin: View {
    var color: Color = AppColor.green()
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
    var color: UIColor

    init(
        coordinate: CLLocationCoordinate2D,
        title: String? = nil,
        image: UIImage? = nil,
        color: UIColor = AppColor.green()
    ) {
        self.coordinate = coordinate
        self.title = title
        self.image = image
        self.color = color
    }
}

#Preview {
    Pin(color: AppColor.green())
}
