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
                HStack {
                    Text("Имя")
                    Spacer()
                    Text(user?.firstName ?? "")
                }
                HStack {
                    Text("Фамилия")
                    Spacer()
                    Text(user?.lastName ?? "")
                }
                HStack {
                    Text("Отчество")
                    Spacer()
                    Text(user?.middleName ?? "")
                }
                HStack {
                    Text("Телефон")
                    Spacer()
                    Text(String(user?.phone ?? 0))
                }
                HStack {
                    Text("Почта")
                    Spacer()
                    Text(user?.email ?? "")
                }
                HStack {
                    Text("ID")
                    Spacer()
                    Text(user?.userID ?? "")
                        .textSelection(.enabled)
                }
            }
        }
    }
}

#Preview {
    AboutUserView()
}
