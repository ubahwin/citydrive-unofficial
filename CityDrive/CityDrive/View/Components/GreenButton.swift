import SwiftUI

struct GreenButton: ButtonStyle {
    var fixHeight: CGFloat?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: fixHeight)
            .background(AppColor.green())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.white)
            .padding()
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .brightness(configuration.isPressed ? -0.1: 0)
    }
}

#Preview {
    Button("Example") { }
        .buttonStyle(GreenButton(fixHeight: 50))
}
