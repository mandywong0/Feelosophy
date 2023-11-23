//
//  ContentView.swift
//  Feelosophy
//
//  Created by Jane Lee on 11/21/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        HStack {
                            Image(systemName: "face.smiling.inverse")
                            Text("Mood at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard)) is \(item.mood)")
                        }
                    } label: {
                        HStack {
                            Image(systemName: "face.smiling.inverse")
                            Text("mood at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
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
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Happy")
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
