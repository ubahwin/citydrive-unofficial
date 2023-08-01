//
//  MapInteractionPickerView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 27.07.2023.
//

import SwiftUI

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
