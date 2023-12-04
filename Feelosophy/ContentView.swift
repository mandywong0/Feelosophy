//
//  ContentView.swift
//  Feelosophy
//
//  Created by Justin Lee on 12/3/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @StateObject var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items.reversed()) { item in
                    NavigationLink {
                        VStack {
                            AsyncImage(url: URL(string:
                                                    item.url)) {
                                image in image.resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .background(RoundedRectangle(cornerRadius: 20).stroke(LinearGradient(gradient: Gradient(colors:[.blue, .green]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/), lineWidth: 5))
                            .shadow(radius: 20)
                            if (item.mood == "Happy") {
                                Text("Your mood was \(item.mood)! Keep up that positive energy by hanging out with some friends, and making sure to spread that positive energy around!")
                            } else if (item.mood == "Sad") {
                                Text("Your mood was \(item.mood)! We all have off days... Everything will turn out okay as long as you continue working hard in life. You got this!")
                            } else if (item.mood == "Alright") {
                                Text("Your mood was \(item.mood)! You should try doing something you love such as taking a walk outside or spending time with your loved ones to make yourself feel great!")
                            } else if (item.mood == "Tired") {
                                Text("Your mood was \(item.mood)! It's okay to take breaks! Burnout is a serious problem so make sure to de-stress and enjoy life without overloading yourself!")
                            }
                        }
                    } label: {
                        HStack {
                            if (item.mood == "Happy" || item.mood == "Alright") {
                                Image(systemName: "face.smiling.inverse")
                                Text("mood at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            } else if (item.mood == "Sad" || item.mood == "Tired"){
                                Image(systemName: "cloud.rain")
                                Text("mood at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[items.count - index - 1])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
