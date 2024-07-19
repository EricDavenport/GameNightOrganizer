import Firebase
import FirebaseFirestore

class GameDatabaseManager {
    static let shaeed = GameDatabaseManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func addGame(game: Game, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = [
            "id" : game.id.uuidString,
            "name" : game.name,
            "numberOfPlayers" : game.numberOfPlayers,
            "isAdultOnly" : game.isAdultOnly
        ]
        
        db.collection("games").document(game.id.uuidString).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func loadGame(completion: @escaping(Result<[Game], Error>) -> Void) {
        db.collection("games").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let games = documents.compactMap { doc -> Game? in
                    let data = doc.data()
                    guard
                        let idString = data["id"] as? String,
                        let id = UUID(uuidString: idString),
                        let name = data["name"] as? String,
                        let numPlayers = data["numberOfPlayers"] as? Int,
                        let isAdultOnly = data["isAdultOnly"] as? Bool
                    else { return nil }
                    
                    return Game(id: id, name: name, numberOfPlayers: numPlayers, isAdultOnly: isAdultOnly)
                }
                completion(.success(games))
            }
        }
    }
}
