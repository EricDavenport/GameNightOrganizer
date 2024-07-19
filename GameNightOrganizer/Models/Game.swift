import Foundation

struct Game: Identifiable {
    var id = UUID()
    var name: String
    var numberOfPlayers: Int
    var isAdultOnly: Bool
//    var suggestBy: UUID? // User ID who suggested the game
}
