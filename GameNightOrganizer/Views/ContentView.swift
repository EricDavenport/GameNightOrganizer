import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    @Published var user: User?
    
    func loadUser() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data() ?? [:]
                    let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                    let name = data["name"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let friendList = data["friednList"] as? [User] ?? []
                    self.user = User(
                        id: id,
                        firebaseID: user.uid,
                        name: name,
                        email: email,
                        friendList: friendList)
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var events: [GameNightEvent] = []
    @State private var showingAddEvent = false
    @State private var users: [User] = []
    @State private var currentUser: User?
    @StateObject var viewModel = AppViewModel()
    @State private var showingAuthView = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            List(events) { gameNight in
                GameNightCell(gameNight: gameNight)
            }
            .navigationTitle("Upcoming Game Nights")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadGameNights)
            .alert(isPresented: .constant(errorMessage != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK")) {
                        errorMessage = nil
                    }
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddEvent = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddEvent) {
            AddEventView(events: $events, users: $users)
        }
    }
    
    private func loadGameNights() {
        EventDatabaseManager.shared.loadGameNights { result in
            switch result {
                case .success(let gameNights):
                    self.events = gameNights
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

#Preview {
    let sampleGames = [
        Game(id: UUID(), name: "Monopoly", numberOfPlayers: 4, isAdultOnly: false, suggestedBy: "Eric"),
        Game(id: UUID(), name: "Poker", numberOfPlayers: 6, isAdultOnly: true, suggestedBy: "Ashlie")
    ]
    
    return ContentView()
}
