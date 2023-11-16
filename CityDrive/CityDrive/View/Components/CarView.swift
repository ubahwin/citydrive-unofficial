import Foundation
import SwiftUI

struct CarView: View {
    @ObservedObject var mapVM: MapViewModel

    var body: some View {
        Text(mapVM.currentCar?.model ?? "Tesla")
    }
}
