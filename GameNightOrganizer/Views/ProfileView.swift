import SwiftUI
import Firebase

struct ProfileView: View {
    @State private var user: User?
    @State private var errorMessage: String?
    @State private var newName = ""
    let userID: String
    
    var body: some View {
        VStack {
            if let user = user {
                TextField("Name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Text("Email: \(user.email)")
                    .padding()
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: updateProfile) {
                    Text("Update Profile")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            } else {
                Text("Loading...")
                    .onAppear(perform: loadUserProfile)
            }
        }
        .padding()
    }
    
    private func loadUserProfile() {
        UserDatabaseManager.shared.loadUserProfile(byID: userID) { result in
            switch result {
                case .success(let user):
                    self.user = user
                    self.newName = user.name
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func updateProfile() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).updateData([
            "name": newName
        ]) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.user?.name = newName
            }
        }
    }
}

#Preview {
    ProfileView(userID: "testUID")
}
