//
//  Item.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 10/03/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
