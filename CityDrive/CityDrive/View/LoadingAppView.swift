import Foundation
import SwiftUI

struct LoadingAppView: View {
    var load: () -> Void
    @State private var timer = Timer.publish(
        every: 20,
        on: .main,
        in: .common
    ).autoconnect()
    @State private var reload = false

    var body: some View {
        VStack {
            Spacer()
            Logo()
            Spacer()
            if reload {
                Button("Ещё раз") {
                    reload = false
                }
                .sensoryFeedback(.increase, trigger: reload)
                .buttonStyle(GreenButton())
            } else {
                ProgressView()
                    .dynamicTypeSize(.accessibility2)
                    .tint(Int.random(in: 0...1) == 1 ? AppColor.purple() : AppColor.green())
                    .shadow(radius: 10)
            }
            Spacer()
        }
        .onAppear {
            load()
        }
        .onReceive(timer) { _ in
            reload = true
        }
    }
}

#Preview {
    LoadingAppView(load: { print("12") })
}
