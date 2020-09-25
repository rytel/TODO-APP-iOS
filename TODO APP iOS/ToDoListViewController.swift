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
        
//        toDoItemArray.append(ToDoItem(name: "name1", category: "category1", date: "date1"))
//        toDoItemArray.append(ToDoItem(name: "name2", category: "category2", date: "date2"))
//        toDoItemArray.append(ToDoItem(name: "name3", category: "category3", date: "date3"))
        
        ToDoTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")


        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    
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
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
