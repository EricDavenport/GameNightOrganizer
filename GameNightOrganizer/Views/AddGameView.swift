import SwiftUI
import Firebase

struct AddGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var games: [Game]
    @State private var gameName = ""
    @State private var gameDescription = ""
    @State private var numberOfPlayers = ""
    @State private var isAdultOnly = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            TextField("Game name", text: $gameName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Number Of Players", text: $numberOfPlayers)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Toggle(isOn: $isAdultOnly) {
                Text("Adult Only")
            }
            .padding()
            
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: addGame) {
                Text("Add Game")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    private func addGame() {
        guard let numberOfPlayers = Int(numberOfPlayers) else {
            errorMessage = "Please enter a va lid number of players."
            return
        }
        
        guard let _ = Auth.auth().currentUser else {
            errorMessage = "No user is currently logged in."
            return
        }
        
        UserDatabaseManager.shared.loadUserProfile { result in
            switch result {
                case .success(let userProfile):
                    let game = Game(
                        id: UUID(),
                        name: gameName,
                        numberOfPlayers: numberOfPlayers,
                        isAdultOnly: isAdultOnly,
                        suggestedBy: userProfile.name
                    )
                    
                    GameDatabaseManager.shared.addGame(game: game) { result in
                        switch result {
                            case .success:
                                errorMessage = "Game Added successfully"
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                        }
                    }
                case .failure(let error):
                    errorMessage = error.localizedDescription
            }
        }
        
        
    }
}


struct AddGameView_Previews: PreviewProvider {
    @State static var games: [Game] = []
    
    static var previews: some View {
        AddGameView(games: $games)
    }
}
