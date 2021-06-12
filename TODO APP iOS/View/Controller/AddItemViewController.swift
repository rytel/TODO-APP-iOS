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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(CONST.itemsPlist)
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        if name.text != "" {
            loadArray()
            itemArray.append(Item(name: name.text, category: category.selectedSegmentIndex, date: date.date))
            saveArray()
        }
        else {
            name.placeholder = "Wypełnij"
        }
    }
    
    //MARK: - func
    
    func saveArray() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: self.dataFilePath!)
            
            let alert = UIAlertController(title: "Zapisano!", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {action in self.navigationController?.popToRootViewController(animated: true)}))
            self.present(alert, animated: true)
        } catch {
            print("Error encoding item array, \(error)")
            
            let alert = UIAlertController(title: "Nie zapisano wydarzenia", message: "Czy chcesz spróbować ponownie?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tak", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Nie", style: .cancel, handler: {action in self.navigationController?.popToRootViewController(animated: true)}))
            self.present(alert, animated: true)
        }
    }
    func loadArray() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding toDoItemArray \(error)")
            }
        }
    }
}

//MARK: - extension

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

