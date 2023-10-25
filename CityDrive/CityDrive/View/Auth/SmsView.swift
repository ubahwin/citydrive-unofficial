import SwiftUI

struct SmsView: View {
    @ObservedObject var loginVM: LoginViewModel

    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            TextField("******", text: $loginVM.smsCode)
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Spacer()
            Button("Войти") {
                loginVM.enter()
            }
            .buttonStyle(GreenButton())
            .fullScreenCover(isPresented: $loginVM.isEntered) {
                ContentView()
            }
            Spacer().frame(height: 50)
        }
        .onTapGesture {
            loginVM.hideKeyboard()
        }
    }
}

#Preview {
    SmsView(loginVM: LoginViewModel())
}
