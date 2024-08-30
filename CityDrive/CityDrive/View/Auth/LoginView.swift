import SwiftUI

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
    @State private var phone = ""

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    Logo()
                    Spacer()
                    HStack {
                        Spacer()
                        Text("+7")
                        TextField("", text: $phone)
                            .keyboardType(.phonePad)
                            .frame(maxWidth: 220)
                        Spacer()
                    }.font(.largeTitle)
                    Spacer()
                    Button("Дальше") {
                        loginVM.sendSmsToPhone(phone)
                    }
                    .sensoryFeedback(.increase, trigger: loginVM.next)
                    .buttonStyle(GreenButton())
                    Spacer().frame(height: 50)
                }
            }
        }
        .onTapGesture { loginVM.hideKeyboard() }
        .fullScreenCover(isPresented: $loginVM.next) { SmsView(loginVM: loginVM) }
    }
}

#Preview {
    LoginView()
}
