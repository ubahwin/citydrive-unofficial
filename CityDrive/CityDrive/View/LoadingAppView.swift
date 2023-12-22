import Foundation
import SwiftUI

struct LoadingAppView: View {
    var body: some View {
        VStack {
            Spacer()
            Logo()
            Spacer()
            ProgressView()
                .dynamicTypeSize(.accessibility2)
                .tint(Int.random(in: 0...1) == 1 ? AppColor.purple() : AppColor.green())
                .shadow(radius: 10)
            Spacer()
        }
    }
}

#Preview {
    LoadingAppView()
}
