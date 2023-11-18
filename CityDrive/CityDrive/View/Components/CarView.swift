import Foundation
import SwiftUI

struct CarView: View {
    @ObservedObject var mapVM: MapViewModel

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: mapVM.currentCar?.img) { image in
                    image
                } placeholder: {
                    Image(systemName: "car")
                }
            }
            Text(mapVM.currentCar?.model ?? "")
        }
    }
}
