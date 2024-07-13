import SwiftUI

struct ContentView: View {
    @State private var events: [GameNightEvent] = []
    @State private var showingAddEvent = false
    @State private var users: [User] = []
    @State private var currentUser: User?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(events) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        Text(event.name)
                    }
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationTitle("Game Nights")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddEvent = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddEvent) {
            AddEventView(events: $events, users: $users)
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
