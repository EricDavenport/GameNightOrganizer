import SwiftUI
import Firebase

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = true
    @State private var errorMessage: String?
    @Binding var stayLoggedIn: Bool
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Toggle(isOn: $stayLoggedIn) {
                Text("Stay logged in")
            }
            .padding()
            
            Button(action: {
                if isSignUp {
                    authViewModel.signUp(email: email, password: password) { result in
                        handleResult(result)
                    }
                } else {
                    authViewModel.signIn(email: email, password: password) { result in
                        handleResult(result)
                    }
                }
            }) {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                isSignUp.toggle()
            }) {
                Text(isSignUp ? "Already have an account? Sign In." : "Don't have an account? Sign up.")
            }
            .padding()
        }
        .padding()
    }
    
    private func handleResult(_ result: Result<Void, Error>) {
        switch result {
            case .success:
                UserDefaults.standard.set(stayLoggedIn, forKey: "stayLoggedIn")
            case .failure(let error):
                errorMessage = error.localizedDescription
        }
    }

}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView(stayLoggedIn: .constant(false))
                .environmentObject(MockAuthViewModel())
                .previewDisplayName("Sign In")
            
            AuthView(stayLoggedIn: .constant(false))
                .environmentObject(MockAuthViewModel())
                .previewDisplayName("Sign Up")
        }
    }
}
