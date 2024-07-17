import SwiftUI
import Firebase

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = true
    @State private var errorMessage: String?
    
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
            
            Button(action: {
                if isSignUp {
                    signUp()
                } else {
                    signIn()
                }
            }) {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if let result = result {
                let user = result.user
                let newUser = User(
                    id: UUID(),
                    firebaseID: user.uid,
                    name: "",
                    email: user.email ?? "",
                    friendList: [],
                    friendIDs: []
                )
                // Save user profile to fireStore
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "id": newUser.id.uuidString,
                    "name": newUser.name,
                    "email": newUser.email,
                    "friendList": [],
                    "friendIDs": []
                ]) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
    
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }}
    }
}

#Preview {
    AuthView()
}
