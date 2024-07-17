import SwiftUI

struct EventDetailView: View {
    var event: GameNightEvent
    @State private var suggestedGames: [Game] = []
    @State private var showingAddGames = false
    
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
                Text(participant.name)
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
        let sampleEvent = GameNightEvent(name: "Sample Event", date: Date(), participants: [User(name: "Eric", email: "a@email.com", friendList: [], friendIDs: [])], games: [Game(name: "Sample Game", numberOfPlayers: 4, isAdultOnly: false, suggestBy: nil)], foodSuggestions: [Food(name: "Pizza", suggestedBy: nil)])
        EventDetailView(event: sampleEvent)
    }
}

