import Foundation
import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var events: [GameNightEvent]
    @State private var eventName = ""
    @State private var eventDate = Date()
    @State private var participants = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $eventName)
                    DatePicker("Date", selection: $eventDate, displayedComponents: .date)
                }
                
                Section(header: Text("Participants")) {
                    TextField("Enter participants seperated by commas", text: $participants)
                }
            }
            .navigationTitle("Add New Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEvent = GameNightEvent(
                            name: eventName,
                            date: eventDate,
                            participants: participants.components(separatedBy: ", ")
                        )
                        events.append(newEvent)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    @State static var events: [GameNightEvent] = []

    static var previews: some View {
        AddEventView(events: $events)
    }
}
