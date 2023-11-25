import SwiftUI

struct GreenButton: ButtonStyle {
    var fixHeight: CGFloat?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: fixHeight)            .background(AppColor.green())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.white)
            .padding()
    }
}

#Preview {
    Button("asfd") { }
        .buttonStyle(GreenButton(fixHeight: 50))
}
