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
        UserDatabaseManager.shared.loadUserProfile { result in
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
        UserDatabaseManager.shared.updateProfile(name: newName) { result in
            switch result {
                case .success:
                    self.user?.name = newName
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    ProfileView()
}
