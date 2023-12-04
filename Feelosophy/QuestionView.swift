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
            Text("Choose Your Mood!")
                .font(.largeTitle)
                .bold()
            Divider()
            Spacer()
            if state == true {
                Text("Thanks for sharing!")
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    .background(.green, in: RoundedRectangle(cornerRadius: 20))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.state.toggle()
                        }
                    }
            }
            VStack(spacing: 30) {
                Button(action: addGood) {
                    Label("I'm currently feeling great!", systemImage: "hand.thumbsup.circle")
                        .bold()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 10, height: 100)
                .background(Color(red: 0.4627, green: 0.5, blue: 1.0), in: RoundedRectangle(cornerRadius: 20))
                Button(action: addAlright) {
                    Label("I'm currently feeling alright!", systemImage: "hand.thumbsup.circle")
                        .bold()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 10, height: 100)
                .background(Color(red: 0.4627, green: 0.5, blue: 1.0), in: RoundedRectangle(cornerRadius: 20))
                Button(action: addBad) {
                    Label("I'm currently feeling sad...", systemImage: "hand.thumbsdown.circle")
                        .bold()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 10, height: 100)
                .background(.pink, in: RoundedRectangle(cornerRadius: 20))
                Button(action: addTired) {
                    Label("I'm currently feeling tired...", systemImage: "hand.thumbsdown.circle")
                        .bold()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 10, height: 100)
                .background(.pink, in: RoundedRectangle(cornerRadius: 20))
            }
            Spacer()
        }
    }
    
    private func addGood() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Happy")
            modelContext.insert(newItem)
            state = true
        }
    }
    
    private func addAlright() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Alright")
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
    
    private func addTired() {
        withAnimation {
            let newItem = Item(timestamp: Date(), mood: "Tired")
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

#Preview {
    QuestionView()
        .modelContainer(for: Item.self, inMemory: true)
}
