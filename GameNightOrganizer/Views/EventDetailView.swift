import SwiftUI

struct EventDetailView: View {
    var event: GameNightEvent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Date: \(event.date, formatter: dateFormatter)")
                            .padding(.bottom)
            
            Text("Participants:")
                .font(.headline)
            
            ForEach(event.participants, id: \.self) { participant in
                Text(participant)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Event Details")
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
//    let sampleEvent = GameNightEvent(name: "Sample Event", date: Date(), participants: ["Eric", "Ashlie", "Wayne"])
    EventDetailView(event: GameNightEvent(name: "Sample Event", date: Date(), participants: ["Eric", "Ashlie", "Wayne"]))
}
