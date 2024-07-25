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
                    let friendList = data["friednList"] as? [String] ?? []
                    let friendIDs = data["friendIDs"] as? [String] ?? []
                    self.user = User(id: id, firebaseID: user.uid, name: name, email: email, friendList: friendList, friendIDs: friendIDs)
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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(events) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        Text(event.name)
                    }
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationTitle("Game Nights")
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
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
