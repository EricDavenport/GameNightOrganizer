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
//    let sampleGames = [
//        Game(id: UUID(), name: "Monopoly", numberOfPlayers: 4, isAdultOnly: false, suggestedBy: "Eric"),
//        Game(id: UUID(), name: "Poker", numberOfPlayers: 6, isAdultOnly: true, suggestedBy: "Ashlie")
//    ]
    
    return ContentView()
}
