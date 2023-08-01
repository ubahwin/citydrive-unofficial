//
//  AboutUserView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI

struct AboutUserView: View {
    var user: UserOrder?
    
    var body: some View {
        List {
            Section(user?.fullName ?? "") {
                SimpleCellView(name: "Имя", value: user?.lastName)
                SimpleCellView(name: "Фамилия", value: user?.lastName)
                SimpleCellView(name: "Отчество", value: user?.middleName)
                SimpleCellView(name: "Телефон", value: user?.phone)
                SimpleCellView(name: "Почта", value: user?.email)
                SimpleCellView(name: "ID", value: user?.userID)
                    .textSelection(.enabled)
            }
        }
    }
}

#Preview {
    AboutUserView()
}
