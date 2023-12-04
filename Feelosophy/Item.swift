//
//  Item.swift
//  Feelosophy
//
//  Created by Justin Lee on 12/3/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var mood: String
    var url: String
    
    
    init(timestamp: Date, mood: String, url: String) {
        self.timestamp = timestamp
        self.mood = mood
        self.url = url
    }
}
