import SwiftUI

struct Logo: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(height: 40)
    }
}

#Preview {
    Logo()
}
