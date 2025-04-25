//
//  UserData.swift
//  ADA-Challenge1
//
//  Created by Komang Wikananda on 25/04/25.
//

import SwiftData

@Model
public class UserData: Identifiable {
    var level: Int
    var spicyCount: Int
    
    init() {
        self.level = 2
        self.spicyCount = 0
    }

    func incrementSpicyCount() {
        if spicyCount < 10 {
            spicyCount += 1
        }
    }
    
    func levelUp() {
        if level < 10 {
            level += 1
        }
    }
    
    func resetLevelTo(level: Int){
        if (level >= 1 && level <= 10) {
            self.level = level
        }
    }
    
    // Reset spicyCount to 0
    func resetSpicyCount() {
        spicyCount = 0
    }
}
