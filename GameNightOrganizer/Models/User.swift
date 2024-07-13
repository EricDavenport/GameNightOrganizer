import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var friendsList: [User]
    var friendIDs: [UUID] // To track friends by ID for easier reference
}
