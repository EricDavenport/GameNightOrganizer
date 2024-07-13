import Foundation

struct Food: Identifiable {
    var id = UUID()
    var name: String
    var suggestedBy: UUID?  // User ID who suggested the food
}
