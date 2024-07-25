import Foundation

struct Game: Identifiable, Codable {
    var id = UUID()
    var name: String
    var numberOfPlayers: Int
    var isAdultOnly: Bool
    var suggestedBy: String
}
