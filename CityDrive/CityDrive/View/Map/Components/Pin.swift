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
    var image: UIImage
    var transferable: Bool

    init(
        id: UUID,
        coordinate: CLLocationCoordinate2D,
        image: UIImage? = nil,
        transferable: Bool
    ) {
        self.id = id
        self.coordinate = coordinate

        if image != nil {
            self.image = image!
        } else {
            let pin = transferable ? UIImage.pinGiveaway : UIImage.pinCar
            self.image = pin.resizePin(height: 20)
        }

        self.transferable = transferable
    }
}

#Preview {
    Pin(color: AppColor.green())
}
