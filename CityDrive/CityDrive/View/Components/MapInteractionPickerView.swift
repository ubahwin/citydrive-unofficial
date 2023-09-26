//
//  MapInteractionPickerView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 27.07.2023.
//

import SwiftUI

struct MapInteractionsView: View {
    @ObservedObject var settingVM: SettingViewModel

    var body: some View {
        NavigationLink(destination: {
            List {
                ForEach(MapInteraction.allCases) { interaction in
                    MapInteractionPickerView(
                        title: interaction.title,
                        isSelected: settingVM.selectedInteractions.contains(interaction.rawValue)
                    ) {
                        if settingVM.selectedInteractions.contains(interaction.rawValue) {
                            settingVM.selectedInteractions.removeAll(where: { $0 == interaction.rawValue })
                        } else {
                            settingVM.selectedInteractions.append(interaction.rawValue)
                        }
                    }
                }
            }
        }, label: {
            HStack {
                Text("Действия с картой")
                Spacer()
                Text(settingVM.selectedInteractions.count.description).colorMultiply(.gray)
            }
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
