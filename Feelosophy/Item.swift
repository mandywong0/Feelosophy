//
//  Item.swift
//  Feelosophy
//
//  Created by Jane Lee on 11/21/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var mood: String
    
    init(timestamp: Date, mood: String) {
        self.timestamp = timestamp
        self.mood = mood
    }
}
