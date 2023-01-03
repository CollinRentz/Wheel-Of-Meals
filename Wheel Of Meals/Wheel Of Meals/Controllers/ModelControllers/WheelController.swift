//
//  WheelController.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/16/22.
//

import Foundation

class WheelController {
    
    static let shared = WheelController()
    
    var wheels: [Wheel] = [
    Wheel(wheelName: "Popular Restaurants", restaurants:             [
        Restaurant(restaurantName: "Wendy's"),
        Restaurant(restaurantName: "Culver's"),
        Restaurant(restaurantName: "Taco Bell"),
        Restaurant(restaurantName: "McDonald's"),
        Restaurant(restaurantName: "Tacotime")
            ]),
    Wheel(wheelName: "Other Restaurants", restaurants:
            [
        Restaurant(restaurantName: "Wendy's"),
        Restaurant(restaurantName: "Culver's"),
        Restaurant(restaurantName: "Taco Bell"),
        Restaurant(restaurantName: "Tacotime")
            ])
    ]
    
    func createWheel(wheelName: String, restaurantName: [Restaurant], id: String = UUID().uuidString) {
        let newWheel = Wheel(wheelName: wheelName, restaurants: restaurantName)
        wheels.append(newWheel)
        saveToPersistenceStore()
    }
    
    func deleteWheel(wheel: Wheel) {
        guard let index = wheels.firstIndex(of: wheel) else { return }
        wheels.remove(at: index)
        saveToPersistenceStore()
    }
    
    func updateWheel(wheel: Wheel, wheelName: String, restaurants: [Restaurant]) {
        guard let index = wheels.firstIndex(of: wheel) else {
            print("Wheel was not found")
            return }
        // let newWheel = Wheel(wheelName: wheelName, restaurants: restaurants)
        // idea 2
        wheels[index].wheelName = wheelName
        wheels[index].restaurants = restaurants
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Wheel.json")
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(wheels)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our wheels: \(error) -- \(error.localizedDescription)")
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            wheels = try JSONDecoder().decode([Wheel].self, from: data)
        } catch {
            print("Error decoding our data into wheels: \(error) -- \(error.localizedDescription)")
        }
    }
}
