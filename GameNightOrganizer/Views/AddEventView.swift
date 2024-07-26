import Foundation
import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var events: [GameNightEvent]
    @Binding var users: [User]
    @State private var eventName = ""
    @State private var eventDate = Date()
    @State private var selectedParticipants: Set<String> = []
    @State private var games: [Game] = []
    @State private var foodSuggestions: [Food] = []
    @State private var showingAddGame = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $eventName)
                    DatePicker("Date", selection: $eventDate, displayedComponents: .date)
                }
                
                Section(header: Text("Participants")) {
                    
                }
                
                Section(header: Text("Games")) {
                    ForEach(games) { game in
                        Text("\(game.name) - \(game.numberOfPlayers) - \(game.isAdultOnly ? "Adult Only" : "All Ages")")
                    }
                    .onDelete { indexSet in
                        games.remove(atOffsets: indexSet)
                    }
                    
                    Button(action: {
                        showingAddGame = true
                    }) {
                        Text("Add Game")
                    }
                    .sheet(isPresented: $showingAddGame) {
                        AddGameView(games: $games)
                    }
                    
                }
                
                Section(header: Text("Food Suggestions")) {
                    ForEach(foodSuggestions) { food in
                        Text(food.name)
                    }
                    .onDelete { indexSet in
                        foodSuggestions.remove(atOffsets: indexSet)
                    }
                    
                    Button(action: addFood) {
                        Text("Add Food")
                    }
                }
            }
            .navigationTitle("Add New Event")
        }
    }
    
    private func addFood() {
        let newFood = Food(name: "New Food", suggestedBy: nil)
        foodSuggestions.append(newFood)
    }
}

struct AddEventView_Previews: PreviewProvider {
    @State static var events: [GameNightEvent] = []
    @State static var users: [User] = [User(firebaseID: "1234", name: "Eric", email: "a@email.com", friendList: []),User(firebaseID: "2341", name: "Danny", email: "a@email.com", friendList: []),User(firebaseID: "3412", name: "Jay", email: "a@email.com", friendList: [])]
    static var previews: some View {
        AddEventView(events: $events, users: $users)
    }
}
