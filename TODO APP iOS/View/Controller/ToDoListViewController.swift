//
//  ViewControllerTableViewController.swift
//  TODO APP iOS
//
//  Created by Rafał Rytel on 25/09/2020.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    @IBOutlet var ToDoTableView: UITableView!
    
    var viewModelArray: [ItemViewModel] = []
    var toDoItemArray: [ToDoItem] = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.dataSource = self
        ToDoTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
        loadArray()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
            cell.nameLabel.text = viewModelArray[indexPath.row].name
            cell.dateLabel.text = viewModelArray[indexPath.row].date
            cell.categoryLabel.text = viewModelArray[indexPath.row].category
        return cell
    }
    
    //MARK: - Save and Load func
    
    func saveArray() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(toDoItemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    func loadArray() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                toDoItemArray = try decoder.decode([ToDoItem].self, from: data)
                for i in 0..<toDoItemArray.count {
                    self.viewModelArray.append(ItemViewModel(toDoItemArray[i]))
                }
            } catch {
                print("Error decoding toDoItemArray \(error)")
            }
        }
    }
}

