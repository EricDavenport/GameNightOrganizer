import SwiftUI

struct EventDetailView: View {
    var event: GameNightEvent
    
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
            
            Spacer()
        }
        .padding()
        .navigationTitle("Event Details")
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

//#Preview {
//    let user1 = User(name: "Eric", friendsList: [], friendIDs: [])
//    let user2 = User(name: "Wayne", friendsList: [], friendIDs: [])
//    let user3 = User(name: "Tima", friendsList: [], friendIDs: [])
//    let user4 = User(name: "Ashlie", friendsList: [], friendIDs: [])
//
//    EventDetailView(event: <#T##GameNightEvent#>)
//}
struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEvent = GameNightEvent(name: "Sample Event", date: Date(), participants: [User(name: "Eric", friendsList: [], friendIDs: [])], games: [Game(name: "Sample Game", numberOfPlayers: 4, isAdultOnly: false, suggestBy: nil)], foodSuggestions: [Food(name: "Pizza", suggestedBy: nil)])
        EventDetailView(event: sampleEvent)
    }
}

