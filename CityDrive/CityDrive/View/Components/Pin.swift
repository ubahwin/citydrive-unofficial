import SwiftUI
import MapKit

struct Pin: View {
    var color: Color
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

#Preview {
    Pin(color: .green)
}
