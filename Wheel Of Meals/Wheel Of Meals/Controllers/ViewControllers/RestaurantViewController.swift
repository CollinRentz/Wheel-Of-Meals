//
//  OptionsViewController.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/15/22.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var wheelNameTextField: UITextField!
    
    @IBOutlet weak var restaurantNameTextField: UITextField!
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    var wheel: Wheel?
    var tempRestaurants: [Restaurant] = []
    //dissmiss keyboard with tap gesture
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        //dismiss keyboard with scrolling gesture
        restaurantTableView.keyboardDismissMode = .onDrag
        updateWheels()
        WheelController.shared.loadFromPersistenceStore()
        // Do any additional setup after loading the view.
        //GIve our text field super powers
        restaurantNameTextField.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restaurantTableView.reloadData()
    }
    func updateWheels() {
        guard let unwrapWheel = wheel else { return }
        wheelNameTextField.text = unwrapWheel.wheelName
        // if the restaurants act up this is why
//        tempRestaurants = unwrapWheel.restaurants
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    //MARK: Table View Stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tempRestaurants.count
        (wheel?.restaurants.count ?? 0) + tempRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
//            let restaurant = tempRestaurants[indexPath.row]
//            guard let wheel = wheel else { return cell }
        if let wheelV2 = wheel {
//            tempRestaurants = []
            var restaurant = wheelV2.restaurants
            for item in tempRestaurants {
                restaurant.append(item)
            }
            let wheelRestaurant = restaurant[indexPath.row]
            content.text = wheelRestaurant.restaurantName
        } else {
            let tempRestaurantV2 = tempRestaurants[indexPath.row]
            content.text = tempRestaurantV2.restaurantName
        }
        
//        var combineArray: [Restaurant] = wheelRestaurant += tempRestaurants
        
//        let restaurant = items[indexPath.row]
        cell.contentConfiguration = content

            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let wheel = wheel else { return }
//            let songToDelete = wheel.songs[indexPath.row]
            let restaurantToDelete = wheel.restaurants[indexPath.row]
            RestaurantController.deleteRestaurant(restaurant: restaurantToDelete, wheel: wheel)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    @IBAction func addRestaurantButtonTapped(_ sender: Any) {
        
        guard let restaurantName = restaurantNameTextField.text, !restaurantName.isEmpty else { return }
        
        if let wheel = wheel {
            // add restaurants to existing wheel
            wheel.restaurants.append(Restaurant(restaurantName: restaurantName))
        } else {
            // no wheel has been created yet
            tempRestaurants.append(Restaurant(restaurantName: restaurantName))
        }
        
        print("\(tempRestaurants.count)")
        restaurantTableView.reloadData()
        restaurantNameTextField.text = ""
        restaurantNameTextField.resignFirstResponder()
        
    }
   
    
     //__
    
    @IBAction func saveToWheelsButton(_ sender: Any) {
        
        if wheel == nil {
            // here is where the create function will go, because i don't have a wheel object
            
            WheelController.shared.createWheel(wheelName: "\(wheelNameTextField.text ?? "")", restaurantName: tempRestaurants)
            
            print("my wheel has been created")
            
        } else {
            guard let wheel = wheel else { return }
            var restaurants = wheel.restaurants
            for item in tempRestaurants {
                restaurants.append(item)
            }
            // here is where the update function will go because i have a wheel
            WheelController.shared.updateWheel(wheel: wheel, wheelName: "\(wheelNameTextField.text ?? "")", restaurants: restaurants)
            print("\(restaurants.count)")
            restaurantTableView.reloadData()
            print("my wheel has been updated")
        }
        navigationController?.popViewController(animated: true)
    }
    
}
