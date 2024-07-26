import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var stayLoggedIn = false
    private var errorMessage = ""
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        self.stayLoggedIn = UserDefaults.standard.bool(forKey: "stayLoggedIn")
        self.authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
            if user == nil && self.stayLoggedIn {
                self.signInAnonymously()
            }
        }
    }
    
    deinit {
        if let listerner = authStateListener {
            Auth.auth().removeStateDidChangeListener(listerner)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.isAuthenticated = true
                completion(.success(()))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.isAuthenticated = true
                completion(.success(()))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            self.errorMessage = error?.localizedDescription ?? "Anonymous sign-in error: \(error!.localizedDescription)"
        }
    }
    
}
