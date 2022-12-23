//
//  Restaurant.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/16/22.
//

import Foundation

class Restaurant: Codable, Equatable {
    var restaurantName: String
    var id: String
    
    init(restaurantName: String, id: String = UUID().uuidString) {
        self.restaurantName = restaurantName
        self.id = id
    }
    
    // Equatable Conformance
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
}
