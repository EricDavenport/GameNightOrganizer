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
                let friendList = data["friendList"] as? [User] ?? []
                let friendIDs = data["friendIDs"] as? [String] ?? []
                let user = User(
                    id: id,
                    firebaseID: user.uid,
                    name: name,
                    email: email,
                    friendList: friendList
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
                let friendList = data["friendLiat"] as? [User] ?? []
                
                let user = User(
                    id: id,
                    firebaseID: uid,
                    name: name,
                    email: email,
                    friendList: friendList
                )
                
                completion(.success(user))
            } else {
                completion(.failure(error ?? NSError(domain: "Documant does not exist", code: -1, userInfo: nil)))
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
    
    func updateUserProfile(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection("users").document(user.firebaseID).setData(from: user) { error in
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
    
    func addFriend(userID: String, friend: User, completion: @escaping (Result<Void, Error>) -> Void) {
        loadUserProfile(byID: userID) { result in
            switch result {
                case .success(var user):
                    if user.friendList.contains(where: { $0.firebaseID == friend.firebaseID }) {
                        user.friendList.append(friend)
                        self.updateUserProfile(user: user, completion: completion)
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func loadFriends(userID: String, completion: @escaping (Result<[User], Error>) -> Void) {
        loadUserProfile(byID: userID) { result in
            switch result {
                case .success(let user):
                    completion(.success(user.friendList))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
