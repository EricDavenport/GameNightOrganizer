import Foundation

struct GameNightEvent: Identifiable {
    var id = UUID()
    var name: String
    var date: Date
    var participants: [User]
    var games: [Game]
    var foodSuggestions: [Food]
}
