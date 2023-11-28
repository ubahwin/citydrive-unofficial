import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var mapVM = MapViewModel()

    var body: some View {
        ZStack {
            ImperativeMapView(mapVM: mapVM)
                .ignoresSafeArea()
                .onTapGesture {
                    mapVM.openCarDetail = false
                }
            VStack {
                HStack {
                    HStack {
                        BonusButtonView(mapVM: mapVM)
                        RefreshMapButtonView(mapVM: mapVM)
                    }
                    Spacer()
                    UserLocationButtonView(goToUser: $mapVM.goToUser)
                }
                Spacer()
            }
            .padding()
            .shadow(radius: 15)
        }
        .sheet(isPresented: $mapVM.openCarDetail) {
            if mapVM.currentCar?.transferable ?? false {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.red)
                    VStack {
                        Text("Вне зоны завершения аренды")
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .opacity(0.8)
                            .padding()
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                        .frame(height: 300)
                    VStack {
                        Spacer(minLength: 60)
                        CarView(mapVM: mapVM)
                            .presentationDetents([.height(345)])
                            .presentationBackgroundInteraction(.enabled(upThrough: .height(345)))
                            .frame(maxHeight: 320)
                    }
                }
            } else {
                CarView(mapVM: mapVM)
                    .presentationDetents([.height(300)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
            }
        }
    }
}

#Preview {
    MapView()
}
