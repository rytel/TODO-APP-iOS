//
//  AddItemViewController.swift
//  TODO APP iOS
//
//  Created by Rafał Rytel on 25/09/2020.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet weak var date: UIDatePicker!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var toDoItemArray: [ToDoItem] = []
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        loadArray()
        let rrrrmmdd = "\(date.date)".prefix(10)
        toDoItemArray.append(ToDoItem(name: name.text, category: category.selectedSegmentIndex, date: "\(rrrrmmdd)"))
        saveArray()
        //ma zostac zapisane do local storage
        
    }
    
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
            } catch {
                print("Error decoding toDoItemArray \(error)")
            }
        }
    }
    
    
}
