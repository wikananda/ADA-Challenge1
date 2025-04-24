//
//  FoodData.swift
//  ADA-Challenge1
//
//  Created by Komang Wikananda on 24/04/25.
//
import Foundation
import SwiftData

@Model
class FoodData: Identifiable {
    var id: String
    var img: String
    var name: String
    var date: Date
    var location: String
    
    var tastiness: Int
    var spiciness: Int
    
    init(img: String, name: String, date: Date, location: String, tastiness: Int, spiciness: Int) {
        self.id = UUID().uuidString
        self.img = img
        self.name = name
        self.date = date
        self.location = location
        self.tastiness = tastiness
        self.spiciness = spiciness
    }
}
