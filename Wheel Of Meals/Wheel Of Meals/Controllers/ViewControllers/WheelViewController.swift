//
//  WheelViewController.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 12/19/22.
//

import UIKit

class WheelViewController: UIViewController {

    @IBOutlet weak var wheelTableView: UITableView!
    
    @IBOutlet weak var addWheelButton: UIBarButtonItem!
    
    var wheels = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wheelTableView.delegate = self
        wheelTableView.dataSource = self
        WheelController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wheelTableView.reloadData()
    }

}

extension WheelViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WheelController.shared.wheels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wheelTableView.dequeueReusableCell(withIdentifier: "wheelCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let wheel = WheelController.shared.wheels[indexPath.row]
        content.text = wheel.wheelName
        cell.contentConfiguration = content
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let wheelToDelete = WheelController.shared.wheels[indexPath.row]
//            WheelController.shared.deleteWheel(wheel: wheelToDelete)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        if let wheelEditView = storyboard?.instantiateViewController(withIdentifier: "wheelEditView") {
//            navigationController?.pushViewController(wheelEditView, animated: true)
//        }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { _,_,_ in
            let wheelToDelete = WheelController.shared.wheels[indexPath.row]
            WheelController.shared.deleteWheel(wheel: wheelToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.image = UIImage(systemName: "trash")

        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            guard let secondVc = self.storyboard?.instantiateViewController(withIdentifier: "wheelEditView") as? RestaurantViewController else { return }
            let wheel = WheelController.shared.wheels[indexPath.row]
            secondVc.wheel = wheel
                self.navigationController?.pushViewController(secondVc, animated: true)
        }
        editAction.backgroundColor = .systemYellow
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
    //    @IBAction func editButtonTapped(_ sender: Any) {
    ////        performSegue(withIdentifier: "toRandomView", sender: nil)
    //        if let secondVc = storyboard?.instantiateViewController(withIdentifier: "secondVc") {
    //            navigationController?.pushViewController(secondVc, animated: true)
    
}
