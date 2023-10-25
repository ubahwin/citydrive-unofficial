import SwiftUI
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject {
    @Published var phone = ""
    @Published var smsCode = ""

    @Published var isEntered = false
    @Published var next = false

    @AppStorage(Settings.isLogged) var isLogged: Bool?

    private let networkManager: NetworkManager

    init() {
        networkManager = NetworkManager()
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func sendSmsToPhone() {
        networkManager.sendPhone(phone: phone) { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let success = response?.success {
                DispatchQueue.main.async {
                    self.next = success
                }
            }
        }
    }

    func enter() {
        networkManager.sendSms(phone: phone, smsCode: Int(smsCode) ?? 0) { response, error in // TODO: replace to VM
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let success = response?.success {
                DispatchQueue.main.async {
                    self.isEntered = success
                }

                self.isLogged = true
                Settings.sessionID = response?.sessionID ?? ""
            }
        }
    }
}
