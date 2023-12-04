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
                ForEach(items) { item in
                    NavigationLink {
                        VStack {
                            if (item.mood == "Happy") {
                                AsyncImage(url: URL(string:
                                                        viewModel.imageURLString)) {
                                    image in image.resizable()
                                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 250, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .background(RoundedRectangle(cornerRadius: 20).stroke(LinearGradient(gradient: Gradient(colors:[.blue, .pink]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/), lineWidth: 5))
                                .shadow(radius: 20)
                                Text("Your mood was \(item.mood)! Keep up that positive energy by hanging out with some friends, and making sure to spread that positive energy around!")
                            } else {
                                AsyncImage(url: URL(string:
                                                        viewModel.imageURLString)) {
                                    image in image.resizable()
                                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 250, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .background(RoundedRectangle(cornerRadius: 20).stroke(LinearGradient(gradient: Gradient(colors:[.blue, .pink]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/), lineWidth: 5))
                                .shadow(radius: 20)
                                Text("Your mood was \(item.mood)! Talk to some friends to make yourself feel better! Remember that you are worth more than your actions.")
                            }
                        }
                    } label: {
                        HStack {
                            if (item.mood == "Happy") {
                                Image(systemName: "face.smiling.inverse")
                                Text("mood at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            } else {
                                Image(systemName: "cloud.rain")
                                Text("mood at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addBad) {
                        Label("Add bad mood", systemImage: "hand.thumbsdown.circle")
                    }
                }
                ToolbarItem {
                    Button(action: addGood) {
                        Label("Add good mood", systemImage: "hand.thumbsup.circle")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addGood() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Happy")
            modelContext.insert(newItem)
        }
    }
    
    private func addBad() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Sad")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
