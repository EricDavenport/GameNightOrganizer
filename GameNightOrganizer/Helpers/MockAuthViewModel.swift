import Foundation
import SwiftUI
import Combine

class MockAuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var stayLoggedIn = false
    
    func signOn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.isAuthenticated = true
        completion(.success(()))
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.isAuthenticated = true
        completion(.success(()))
    }
    
    func signOut() {
        self.isAuthenticated = false
    }
}
