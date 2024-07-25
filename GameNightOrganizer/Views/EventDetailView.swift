import SwiftUI

struct EventDetailView: View {
    var event: GameNightEvent
    @State private var suggestedGames: [Game] = []
    @State private var showingAddGames = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Date: \(event.date, formatter: dateFormatter)")
                .padding(.bottom)
            
            Text("Participants:")
                .font(.headline)
            
            ForEach(event.participants) { participant in
                let user = UserDatabaseManager.shared.loadUserProfile { result in
                    switch result {
                        case .success(let user):
                            Text(user.name)
                        case .failure(let error):
                            Text("Error loading user profile")
                            self.errorMessage = error.localizedDescription
                            
                    }
                }
            }
            
            Text("Games:")
                .font(.headline)
            
            ForEach(event.games) { game in
                Text("\(game.name) - \(game.numberOfPlayers) players - \(game.isAdultOnly ? "Adult Only" : "All Ages")")
            }
            
            Text("Food Suggestions:")
                .font(.headline)
            
            ForEach(event.foodSuggestions) { food in
                Text(food.name)
            }
            
            if isHost {
                
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Event Details")
    }
    
    private var isHost: Bool {
        return true
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEvent = GameNightEvent(id: UUID(), name: "Sample Event", date: Date(), participants: [], games: [Game(name: "Sample Game", numberOfPlayers: 4, isAdultOnly: false, suggestedBy: "Eric")], foodSuggestions: [Food(name: "Pizza")])
        EventDetailView(event: sampleEvent)
    }
}

