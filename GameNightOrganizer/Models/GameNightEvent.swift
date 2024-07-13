import Foundation

struct GameNightEvent: Identifiable {
    var id = UUID()
    var name: String
    var date: Date
    var participants: [String]
}
