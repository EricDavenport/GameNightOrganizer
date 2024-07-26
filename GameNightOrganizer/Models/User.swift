import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var firebaseID: String
    var name: String
    var email: String
    var friendList: [User]
    
    init(id: UUID = UUID(), firebaseID: String, name: String, email: String, friendList: [User]) {
        self.id = id
        self.firebaseID = firebaseID
        self.name = name
        self.email = email
        self.friendList = friendList
    }
}
