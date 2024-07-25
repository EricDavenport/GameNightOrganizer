import Foundation

struct GameNightEvent: Identifiable, Codable {
    var id: UUID
    var name: String
    var date: Date
    var participants: [User]
    var games: [Game]
    var foodSuggestions: [Food]
    var location: String
    
    init(id: UUID = UUID(), name: String, date: Date = Date(), participants: [User] = [], games: [Game] = [], foodSuggestions: [Food] = [], location: String = "") {
        self.id = id
        self.name = name
        self.date = date
        self.participants = participants
        self.games = games
        self.foodSuggestions = foodSuggestions
        self.location = location
    }
}
