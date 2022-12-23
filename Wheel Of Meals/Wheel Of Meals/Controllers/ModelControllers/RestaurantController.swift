//
//  RestaurantController.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/16/22.
//

import Foundation

class RestaurantController {
    
    static func createRestaurant(restaurantName: String, wheel: Wheel) {
        let newRestaurant = Restaurant(restaurantName: restaurantName)
        wheel.restaurants.append(newRestaurant)
        print("Successfully added \(newRestaurant.restaurantName) to \(wheel.wheelName).")
        WheelController.shared.saveToPersistenceStore()
    }
    static func deleteRestaurant(restaurant: Restaurant, wheel: Wheel) {
        guard let index = wheel.restaurants.firstIndex(of: restaurant) else { return }
        wheel.restaurants.remove(at: index)
        print("Successfully deleted \(restaurant.restaurantName) from \(wheel.wheelName).")
        WheelController.shared.saveToPersistenceStore()
    }
}

