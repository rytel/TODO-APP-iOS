//
//  ViewControllerTableViewController.swift
//  TODO APP iOS
//
//  Created by Rafał Rytel on 25/09/2020.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    @IBOutlet var ToDoTableView: UITableView!
    
    var toDoItemArray: [ToDoItem] = [ToDoItem(name: "name1", category: "category1", date: "date1"), ToDoItem(name: "namedsa2", category: "category2", date: "date2"), ToDoItem(name: "name3", category: "category3", date: "date3")]
    
    let defaults = UserDefaults .standard
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.dataSource = self
        
        ToDoTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        
        cell.nameLabel.text = toDoItemArray[indexPath.row].name
        cell.dateLabel.text = toDoItemArray[indexPath.row].date
        cell.categoryLabel.text = toDoItemArray[indexPath.row].category
        return cell
    }
    
    
}
