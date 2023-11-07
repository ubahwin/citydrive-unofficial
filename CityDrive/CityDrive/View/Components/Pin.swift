import SwiftUI
import MapKit

struct Pin: View {
    var color: Color = AppColor.baseGreen()
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
    var height: CGFloat = 20
    var color: UIColor = AppColor.baseGreen()

    init(title: String? = nil, coordinate: CLLocationCoordinate2D) {
        let pin = UIImage(named: "pin")?.resizePin(height: height)
        self.image = pin
        self.title = title
        self.coordinate = coordinate
    }
}

#Preview {
    Pin(color: AppColor.baseGreen())
}
