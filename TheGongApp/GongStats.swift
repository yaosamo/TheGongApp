//
//  Item.swift
//  TheGongApp
//
//  Created by Yaroslav Samoylov on 6/21/25.
//

import Foundation
import SwiftData

@Model
final class GongStats {
    var hitCount: Int
    
    init(hitCount: Int) {
        self.hitCount = hitCount
    }
}
