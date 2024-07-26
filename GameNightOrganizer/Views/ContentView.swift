import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var eventDatabaseManager = EventDatabaseManager.shared
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainFeedView()
                    .environmentObject(authViewModel)
            } else {
                AuthView(stayLoggedIn: $authViewModel.stayLoggedIn)
                    .environmentObject(authViewModel)
            }
        }
    }
    
}

#Preview {
    ContentView()
}
