import SwiftUI

struct MapInteractionsView: View {
    @ObservedObject var settingVM: SettingViewModel

    var body: some View {
        NavigationLink(destination: {
            List {
                ForEach(0..<4) { number in
                    MapInteractionPickerView(
                        title: number.description,
                        isSelected: false
                    ) {
                        print("nothing")
                    }
                }
            }
        }, label: {
            Text("Действия с картой")
        })
    }
}

struct MapInteractionPickerView: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    MapInteractionPickerView(title: "hui", isSelected: true, action: { print("hui") })
}
