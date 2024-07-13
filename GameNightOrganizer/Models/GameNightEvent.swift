import Foundation

struct GameNightEvent: Identifiable {
    var id = UUID()
    var name: String
    var date: Date
    var participants: [User]
    var games: [Game]  // Games for game night
    var foodSuggestions: [Food]  // Food suggestions for the game night
}
