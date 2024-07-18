import Foundation
import SwiftUI

struct AddGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var games: [Game]
    @State private var gameName = ""
    @State private var gameDescription = ""
    @State private var numberOfPlayers = 2
    @State private var isAdultOnly = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Details")) {
                    TextField("Name of game", text: $gameName)
                    Stepper(value: $numberOfPlayers, in: 2...20) {
                        Text("Number of players: \(numberOfPlayers)")
                    }
                    Toggle(isOn: $isAdultOnly) {
                        Text("Adult Only")
                    }
                    TextField("Game description", text: $gameDescription)
                }
            }
            .navigationTitle("New Game")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newGame = Game(name: gameName, numberOfPlayers: numberOfPlayers, isAdultOnly: isAdultOnly, suggestBy: nil)
                        games.append(newGame)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
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
