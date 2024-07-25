import Foundation

struct Food: Identifiable, Codable {
    var id = UUID()
    var name: String
    var suggestedBy: String?  // User ID who suggested the food
}
