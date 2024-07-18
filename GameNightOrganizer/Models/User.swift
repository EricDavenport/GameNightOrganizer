import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var firebaseID: String
    var name: String
    var email: String
    var friendList: [UUID]
    var friendIDs: [String]  // Store firebase IDs
}
