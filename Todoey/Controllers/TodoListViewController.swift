//
//  ViewController.swift
//  Todoey
//
//  Created by Hakan Kaya on 4.08.2019.
//  Copyright © 2019 Hakan Kaya. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        do {
            if let data = try? Data(contentsOf: dataFilePath!)
            {
                let decoder = PropertyListDecoder()
                
                do {
                    itemArray = try decoder.decode([Item].self, from: data)
                }
                catch {
                    print("Error decoding item array, \(error)")
                }
            }
        }
        catch {
            print("Error loading data, \(error)")
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                
                self.itemArray.append(Item(title: textField.text!, done: false))
                
                self.saveItems()
            }
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
