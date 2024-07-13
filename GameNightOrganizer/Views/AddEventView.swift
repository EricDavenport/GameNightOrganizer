import Foundation
import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var events: [GameNightEvent]
    @Binding var users: [User]
    @State private var eventName = ""
    @State private var eventDate = Date()
    @State private var selectedParticipants: Set<UUID> = []
    @State private var games: [Game] = []
    @State private var foodSuggestions: [Food] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $eventName)
                    DatePicker("Date", selection: $eventDate, displayedComponents: .date)
                }
                
                Section(header: Text("Participants")) {
                    List(users) { user in
                        MultipleSelectionRow(title: user.name, isSelected: selectedParticipants.contains(user.id)) {
                            if selectedParticipants.contains(user.id) {
                                selectedParticipants.remove(user.id)
                            } else {
                                selectedParticipants.insert(user.id)
                            }
                        }
                    }
                }
                
                Section(header: Text("Games")) {
                    ForEach(games) { game in
                        Text("\(game.name) - \(game.numberOfPlayers) - \(game.isAdultOnly ? "Adult Only" : "All Ages")")
                    }
                    .onDelete { indexSet in
                        games.remove(atOffsets: indexSet)
                    }
                    
                    Button(action: addGame) {
                        Text("Add Game")
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let participants = users.filter { selectedParticipants.contains($0.id) }
                        let newEvent = GameNightEvent(
                            name: eventName,
                            date: eventDate,
                            participants: participants,
                            games: games,
                            foodSuggestions: foodSuggestions
                        )
                        events.append(newEvent)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
        }
    }
    
    private func addGame() {
        let newGame = Game(name: "New Game", numberOfPlayers: 4, isAdultOnly: false)
        games.append(newGame)
    }
    
    private func addFood() {
        let newFood = Food(name: "New Food", suggestedBy: nil)
        foodSuggestions.append(newFood)
    }
}

struct AddEventView_Previews: PreviewProvider {
    @State static var events: [GameNightEvent] = []
    @State static var users: [User] = [User(name: "Eric", friendsList: [], friendIDs: [])]
    static var previews: some View {
        AddEventView(events: $events, users: $users)
    }
}
