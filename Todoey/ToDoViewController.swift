//
//  ViewController.swift
//  Todoey
//
//  Created by Shouri on 4/7/18.
//  Copyright © 2018 Shouri Piratla. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var items : [String] = []
    var userDefualts = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let arr = userDefualts.value(forKey: "ToDoItems") as? [String]{
            items = arr
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem){
        
        var newItemText = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.items.append(newItemText.text!)
            self.userDefualts.set(items, forKey: "ToDoItems")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
