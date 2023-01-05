//
//  Wheel.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/15/22.
//

import Foundation

class Wheel: Codable, Equatable {
    
    var wheelName: String
    var restaurants: [Restaurant]
    var id: String
    var wheelSelected: Bool = false
    
    init(wheelName: String, restaurants: [Restaurant], id: String = UUID().uuidString, wheelSelected: Bool) {
        self.wheelName = wheelName
        self.restaurants = restaurants
        self.id = id
        self.wheelSelected = wheelSelected
    }
    
    // Equatable Conformance
    static func == (lhs: Wheel, rhs: Wheel) -> Bool {
        return lhs.id == rhs.id
    }
}
