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
    var itemArray: [Item] = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.dataSource = self
        ToDoTableView.register(UINib(nibName: CONST.ToDoTableViewCell, bundle: nil), forCellReuseIdentifier: CONST.ToDoTableViewCell)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CONST.ToDoTableViewCell, for: indexPath) as! ToDoTableViewCell
        cell.nameLabel.text = viewModelArray[indexPath.row].name
        cell.dateLabel.text = viewModelArray[indexPath.row].date
        cell.categoryLabel.text = viewModelArray[indexPath.row].category
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let alert = UIAlertController(title: "Czy chcesz usunąć wydarzenie", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tak", style: .default, handler: {action in
                tableView.beginUpdates()
                self.itemArray.remove(at: indexPath.row)
                self.viewModelArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                tableView.reloadData()
                let encoder = PropertyListEncoder()
                do {
                    let data = try encoder.encode(self.itemArray)
                    try data.write(to: self.dataFilePath!)
                    let alert = UIAlertController(title: "Usunięto!", message: nil, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                } catch {
                    print("Error encoding item array, \(error)")
                }
            }))
            alert.addAction(UIAlertAction(title: "Nie", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - func
    
    func loadArray() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
                for i in self.viewModelArray.count..<itemArray.count {
                    self.viewModelArray.append(ItemViewModel(itemArray[i]))
                }
            } catch {
                print("Error decoding toDoItemArray \(error)")
            }
        }
    }
}

//MARK: - extension
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
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
