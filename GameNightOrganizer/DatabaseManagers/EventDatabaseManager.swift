import Firebase
import FirebaseFirestore

class EventDatabaseManager {
    static let shared = EventDatabaseManager()
    
    private init() {}
    
    private let db = Firestore.firestore()
}
