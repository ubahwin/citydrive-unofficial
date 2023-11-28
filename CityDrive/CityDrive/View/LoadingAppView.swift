import Foundation
import SwiftUI

struct LoadingAppView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#Preview {
    LoadingAppView()
}
