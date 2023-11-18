import SwiftUI
import MapKit
import CoreMotion

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

class UserAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            if newValue is MKUserLocation {
                calloutOffset = CGPoint(x: -5, y: 5)
                image = UIImage(named: "position")?.resizePin(height: 35)
            }
        }
    }
}

class ImperativeMapPin: NSObject, Identifiable, MKAnnotation {
    var id: UUID
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?

    init(car: Car) {
        self.id = car.id
        self.coordinate = car.location.coordinate

        let color: UIColor = car.transferable ? AppColor.red() : AppColor.green()
        self.image = UIImage.drawPin(color: color).resizePin(height: 25)
    }
}

#Preview {
    Pin(color: AppColor.green())
}
