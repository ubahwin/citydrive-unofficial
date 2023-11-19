import Foundation
import SwiftUI

struct UserLocationButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var goToUser: Bool

    var body: some View {
        VStack {
            Button(
                action: { goToUser.toggle() },
                label: { Image(systemName: "location.fill") }
            )
            .padding(10)
            .background(colorScheme == .dark ? .black : .white)
            .foregroundStyle(AppColor.green())
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
