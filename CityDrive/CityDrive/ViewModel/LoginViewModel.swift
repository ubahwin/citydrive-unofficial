//
//  LoginViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 02.08.2023.
//

import SwiftUI
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject {
    @Published var phone = ""
    @Published var smsCode = ""
    
    @Published var isEntered = false
    @Published var next = false

    private var networkManager: NetworkManager
        
    init() {
        networkManager = NetworkManager()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func sendSmsToPhone() {
        networkManager.sendPhone(phone: phone) { response, error in
            if let success = response?.success {
                DispatchQueue.main.async {
                    self.next = success
                }
            }
        }
    }
    
    func enter() {
        networkManager.sendSms(phone: phone, smsCode: Int(smsCode) ?? 0) { response, error in // TODO: replace to VM
            if let success = response?.success {
                DispatchQueue.main.async {
                    self.isEntered = success
                }
                UserDefaults.standard.set(success, forKey: "isLogged")
                KeychainWrapper.standard.set(response?.sessionID ?? "", forKey: "sessionID") // token security
            }
        }
    }
    
    func signInVK() {
        if let url = URL(string: "https://oauth.vk.com/authorize?client_id=51722134&redirect_uri=https://citydrive-unofficial.ru/auth/vk-connect&scope=12&display=mobile"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
