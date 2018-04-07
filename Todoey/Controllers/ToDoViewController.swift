//
//  ViewController.swift
//  Todoey
//
//  Created by Shouri on 4/7/18.
//  Copyright © 2018 Shouri Piratla. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var items = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData()
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        items[indexPath.row].done = !items[indexPath.row].done
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveData(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding items \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadData(){
        if let data = try? Data(contentsOf : dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                items = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error in decoding \(error)")
            }
            
        }
    }
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem){
        
        var newItemText = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
                let newitm = Item()
                newitm.title = newItemText.text!
                newitm.done = false
                self.items.append(newitm)
                self.saveData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
