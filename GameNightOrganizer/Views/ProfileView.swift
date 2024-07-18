import SwiftUI
import Firebase

struct ProfileView: View {
    @State private var user: User?
    @State private var errorMessage: String?
    @State private var newName = ""
    
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
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let friendList = (data["friendList"] as? [String] ?? []).compactMap { UUID(uuidString: $0) }
                let friendIDs = data["friendIDs"] as? [String] ?? []
                self.user = User(
                    id: id,
                    firebaseID: user.uid,
                    name: name,
                    email: email,
                    friendList: friendList,
                    friendIDs: friendIDs
                )
                self.newName = name
            } else {
                self.errorMessage = error?.localizedDescription
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
    ProfileView()
}
