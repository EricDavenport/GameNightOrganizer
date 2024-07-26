import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventDatabaseManager: ObservableObject {
    static let shared = EventDatabaseManager()
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    func saveGameNight(event: GameNightEvent, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection("gameNights").document(event.id.uuidString).setData(from: event) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func loadGameNights(completion: @escaping (Result<[GameNightEvent], Error>) -> Void) {
        db.collection("gameNights").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let events = snapshot?.documents.compactMap { document in
                    try? document.data(as: GameNightEvent.self)
                } ?? []
                completion(.success(events))
            }
        }
    }
    
//    func loadGameNight(eventID: UUID, completion: @escaping (Result<GameNightEvent, Error>) -> Void) {
//        db.collection("gameNights").document(eventID.uuidString).getDocument { document, error in
//            if let document = document, document.exists {
//                do {
//                    if let event = try document.data(as: GameNightEvent.self) {
//                        completion(.success(event))
//                    } else {
//                        completion(.failure(NSError(domain: "EventDatabaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Event not found"])))
//                    }
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
    
    func addEvent(event: GameNightEvent, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = [
            "id": event.id.uuidString,
            "name": event.name,
            "data": event.date,
            "participants": event.participants,
            "games": event.games.map { $0.id.uuidString },
            "foodSuggestions": event.foodSuggestions
        ]
        
        db.collection("events").document(event.id.uuidString).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
//    func loadEvents(completion: @escaping (Result<[GameNightEvent], Error>) -> Void) {
//        db.collection("events").getDocuments { snapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let documents = snapshot?.documents else {
//                completion(.success([]))
//                return
//            }
//            
//            let events = documents.compactMap { doc -> GameNightEvent? in
//                let data = doc.data()
//                guard
//                    let idString = data["id"] as? String,
//                    let id = UUID(uuidString: idString),
//                    let name = data["name"] as? String,
//                    let timestamp = data["date"] as? Timestamp,
//                    let participants = data["participants"] as? [String],
//                    let games = data["games"] as? [String],
//                    let foodSuggestions = data["foodSuggestions"] as? [Food]
//                else { return nil }
//                
//                return GameNightEvent(
//                    id: id,
//                    name: name,
//                    date: timestamp.dateValue(),
//                    participants: participants,
//                    // TODO: Placeholder for games in event database manager
//                    games: games.compactMap { Game(id: UUID(uuidString: $0) ?? UUID(), name: "", numberOfPlayers: 0, isAdultOnly: false, suggestedBy: "Replace this event") },
//                    foodSuggestions: foodSuggestions
//                )
//            }
//            completion(.success(events))
//        }
//    }
}
