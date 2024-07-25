import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var firebaseID: String
    var name: String
    var email: String
    var friendList: [String]
    var friendIDs: [String]  // Store firebase IDs
    
    init(id: UUID = UUID(), firebaseID: String, name: String, email: String, friendList: [String], friendIDs: [String]) {
        self.id = id
        self.firebaseID = firebaseID
        self.name = name
        self.email = email
        self.friendList = friendList
        self.friendIDs = friendIDs
    }
}
