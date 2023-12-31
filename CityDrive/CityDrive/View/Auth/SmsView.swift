import SwiftUI

struct SmsView: View {
    @ObservedObject var loginVM: LoginViewModel
    @State private var smsCode = ""

    var body: some View {
        VStack {
            Spacer()
            Logo()
            Spacer()
            TextField("******", text: $smsCode)
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Spacer()
            Button("Войти") {
                loginVM.enter(with: smsCode)
            }
            .buttonStyle(GreenButton())
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
