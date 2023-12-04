//
//  MainMenuView.swift
//  Feelosophy
//
//  Created by Justin Lee on 12/3/23.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack{
            Spacer()
            Text("Welcome to Feelosophy!").font(.title)
            Spacer()
            Text("This app was created with the mental health of students in mind. Whether you're feeling on top of the world, or down in the dumps, this app will provide you with actionable suggestions on what to do based on how you are feeling. Here at Feelosophy, we believe that it's crucial to stay in touch with your own emotions.  ").frame(width:300).multilineTextAlignment(.center)
            Spacer()
            Text("We understand that this app may not be able to replace or provide professional medical services. If you need more help, please utilize these mental health resources:").frame(width:300).multilineTextAlignment(.center)
            Spacer()
            Text("- Urgent Drop In Counseling: (510) 642-9494")
            Text("- National suicide prevention hotline: Dial 988")
            Text("- Path to Care: Dial (510) 643-2005")
            Spacer()
            
            
        }
    }
}

#Preview {
    MainMenuView()
}
