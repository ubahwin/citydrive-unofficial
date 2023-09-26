import SwiftUI
import MapKit

struct Pin: View {
    var color: Color

    var body: some View {
        Circle()
            .fill(color)
            .stroke(Color.white, lineWidth: 2)
            .frame(height: 10)
            .shadow(radius: 1)
    }
}

#Preview {
    Pin(color: .green)
}
