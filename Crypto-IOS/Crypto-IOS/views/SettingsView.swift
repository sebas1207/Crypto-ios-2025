import SwiftUI

struct SettingsView: View {
    @State var viewModel: SettingsViewModel =
    SettingsViewModel()
    var body: some View {
        if let user = viewModel.user{
            userView(user: user)
        }else{
            loginForm().alert(viewModel.errorMessage, isPresented: $viewModel.showError,)
        }
    }
    
    @ViewBuilder
    func loginForm() -> some View {
        VStack {
            Spacer()
            TextField("email", text: $viewModel.email).textFieldStyle(.roundedBorder)
            SecureField("password", text: $viewModel.password).textFieldStyle(.roundedBorder)
            Button {
                Task {
                    await viewModel.login()
                }
            } label: {
                Text("Login")
            }
            .padding(.vertical)
            Spacer()
        }.padding()
    }
}
#Preview {
    SettingsView()
}
