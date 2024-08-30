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
            .sensoryFeedback(.increase, trigger: goToUser)
            .padding(10)
            .background(colorScheme == .dark ? .black : .white)
            .foregroundStyle(colorScheme == .dark ? AppColor.green() : .black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
