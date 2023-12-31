import SwiftUI

struct SimpleCellView: View {
    var name: String
    var value: CustomStringConvertible?

    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(value?.description ?? "")
        }
    }
}

#Preview {
    SimpleCellView(name: "Имя", value: "Ivan")
}
