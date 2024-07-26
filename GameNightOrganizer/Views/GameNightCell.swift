import SwiftUI

struct GameNightCell: View {
    var gameNight: GameNightEvent
//    let formatter = DateFormatter()
//    formatter.dateFormat = "dd MM yy"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(gameNight.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                Text(gameNight.date, format: .dateTime.day().month().year(.twoDigits))
                    .frame(maxWidth: .infinity)
            }
            .padding(2)
            
            HStack(spacing: 5) {
                VStack {
                    Text("Food")
                    Text("\(gameNight.foodSuggestions.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .background(.blue)
                .cornerRadius(3)
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Participants")
                    Text("\(gameNight.participants.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth:.infinity)
                
                VStack {
                    Text("Location")
                    Text(gameNight.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .frame(maxWidth:.infinity)
            }
            .padding(2)
        }
        .background(Color(.systemGray4))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(10)
    }
}

#Preview {
    let sampleGames = [
        Game(id: UUID(), name: "Monopoly", numberOfPlayers: 4, isAdultOnly: false, suggestedBy: "Eric"),
        Game(id: UUID(), name: "Poker", numberOfPlayers: 6, isAdultOnly: true, suggestedBy: "Ashlie")
    ]
    let sampleEvent = GameNightEvent(
        id: UUID(),
        name: "Sample Event",
        date: Date(),
        participants: [],
        games: sampleGames,
        foodSuggestions: [Food(name: "Pizza"), Food(name: "Chinese")],
        location: "Eric's House"
    )
    return GameNightCell(gameNight: sampleEvent)
}
