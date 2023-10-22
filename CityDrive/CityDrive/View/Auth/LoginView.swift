import SwiftUI

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    Image("logo")
                    Spacer()
                    HStack {
                        Spacer()
                        Text("+7")
                        TextField("", text: $loginVM.phone)
                            .keyboardType(.phonePad)
                            .frame(maxWidth: 220)
                        Spacer()
                    }.font(.largeTitle)
                    Spacer()
                    Button("Дальше") {
                        loginVM.sendSmsToPhone()
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
        .onTapGesture {
            loginVM.hideKeyboard()
        }
        .fullScreenCover(isPresented: $loginVM.next, content: { SmsView(loginVM: loginVM) })
        .fullScreenCover(isPresented: $loginVM.isEntered, content: { ContentView() })
    }
}

#Preview {
    LoginView()
}
