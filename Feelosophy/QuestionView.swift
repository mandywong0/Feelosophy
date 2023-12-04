//
//  QuestionView.swift
//  Feelosophy
//
//  Created by Justin Lee on 12/3/23.
//

import SwiftUI
import SwiftData

struct QuestionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var state: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                LazyVStack(spacing: 30) {
                    Button(action: addBad) {
                        Label("Add bad mood", systemImage: "hand.thumbsdown.circle")
                    }
                    Button(action: addGood) {
                        Label("Add good mood", systemImage: "hand.thumbsup.circle")
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 40)
            .navigationTitle("Add your Mood!")
            if state == true {
                Text("Added!")
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 10, height: 100)
                    .background(.green, in: RoundedRectangle(cornerRadius: 20))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.state.toggle()
                        }
                    }
            }
        }
    }
    
    private func addGood() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Happy")
            modelContext.insert(newItem)
            state = true
        }
    }
    
    private func addBad() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Sad")
            modelContext.insert(newItem)
            state = true
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

struct SuccessNotification: View {
    var body: some View {
        Text("Success")
            .padding()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 10, height: 100)
            .background(.green, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    QuestionView()
        .modelContainer(for: Item.self, inMemory: true)
}
