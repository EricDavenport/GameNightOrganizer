import Firebase
import FirebaseFirestore

class UserDatabaseManager {
    static let shared = UserDatabaseManager()
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    
    func loadUserProfile(completion: @escaping (Result<User, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is currently logged in."])))
            return
        }
        
        db.collection("users").document(user.uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let friendList = data["friendList"] as? [String] ?? []
                let friendIDs = data["friendIDs"] as? [String] ?? []
                let user = User(
                    id: id,
                    firebaseID: user.uid,
                    name: name,
                    email: email,
                    friendList: friendList,
                    friendIDs: friendIDs
                )
                completion(.success(user))
            } else {
                completion(.failure(error ?? NSError(domain: "Firestore Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist."])))
            }
        }
    }
    
    func loadUserProfile(byID uid: String, completion: @escaping (Result<User, Error>) ->Void) {
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let friendList = (data["friendLiat"] as? [String] ?? []).compactMap { UUID(uuidString: $0) }
                let friendIDs = data["friendIDs"] as? [String] ?? []
                
                let user = User(
                    id: id,
                    firebaseID: uid,
                    name: name,
                    email: email,
                    friendList: friendList,
                    friendIDs: friendIDs
                )
            }
        }
    }
    
    func updateProfile(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "Auth Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is currently logged in."])))
            return
        }
        
        db.collection("users").document(user.uid).updateData([
            "name" : name
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
