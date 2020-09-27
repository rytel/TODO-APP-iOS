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
    override func viewWillAppear(_ animated: Bool) {
        loadArray()
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModelArray.count == 0 {
                self.tableView.setEmptyMessage("Lista Pusta")
            } else {
                self.tableView.restore()
            }

        return viewModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        cell.nameLabel.text = viewModelArray[indexPath.row].name
        cell.dateLabel.text = viewModelArray[indexPath.row].date
        cell.categoryLabel.text = viewModelArray[indexPath.row].category
        return cell
    }
    
    //MARK: -func
    
    func loadArray() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                toDoItemArray = try decoder.decode([ToDoItem].self, from: data)
                for i in self.viewModelArray.count..<toDoItemArray.count {
                    self.viewModelArray.append(ItemViewModel(toDoItemArray[i]))
                }

            } catch {
                print("Error decoding toDoItemArray \(error)")
            }
        }
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
