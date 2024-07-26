import SwiftUI

class AppViewModel: ObservableObject {
    @Published var user: User?
    
    func loadUser() {
        UserDatabaseManager.shared.loadUserProfile { result in
            switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct MainFeedView: View {
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
    MainFeedView()
}
