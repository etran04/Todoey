//
//  ViewController.swift
//  Todoey
//
//  Created by Eric Tran on 5/24/18.
//  Copyright © 2018 Eric Tran. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itemArray.append(Item(task: "test 1", isChecked: false))
        itemArray.append(Item(task: "test 2", isChecked: false))
        itemArray.append(Item(task: "test 3", isChecked: false))
    
        // userdefault is used only to save small dtails, not as a database!!
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
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(Item(task: textField.text!, isChecked: false))
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
}

