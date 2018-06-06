//
//  ViewController.swift
//  Todoey
//
//  Created by Eric Tran on 5/24/18.
//  Copyright © 2018 Eric Tran. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.task
        cell.accessoryType = item.isChecked == true ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        self.saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.task = textField.text!
            newItem.isChecked = false
            
            self.itemArray.append(newItem)
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    //MARK: - Model manipulation methods
    func saveData() {
        do {
            try context.save()
        } catch {
            print("failed to save, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
           itemArray = try context.fetch(request)
        } catch {
            print("failed to fetch, \(error)")
        }
    }
}

