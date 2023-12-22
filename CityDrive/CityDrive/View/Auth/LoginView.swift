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
                    .buttonStyle(GreenButton())
                    Spacer().frame(height: 30)

//                    Button(action: {
//                        loginVM.signInVK()
//                    }, label: {
//                        HStack {
//                            Text("Войти через")
//                            Image("vk")
//                                .resizable()
//                                .frame(width: 25, height: 25)
//                        }
//                    })

                    Spacer().frame(height: 20)
                }
            }
        }
        .onTapGesture { loginVM.hideKeyboard() }
        .fullScreenCover(isPresented: $loginVM.next) { SmsView(loginVM: loginVM) }
        .fullScreenCover(isPresented: $loginVM.isEntered) { ContentView() }
    }
}

#Preview {
    LoginView()
}
