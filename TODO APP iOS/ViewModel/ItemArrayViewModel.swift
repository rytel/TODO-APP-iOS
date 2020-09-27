//
//  ItemArrayViewModel.swift
//  TODO APP iOS
//
//  Created by Rafał Rytel on 27/09/2020.
//

import Foundation

class ItemArrayViewModel {
    var itemArray: [ToDoItem]
    
    init(itemArray: [ToDoItem]){
        self.itemArray = itemArray
    }
    func count() -> Int{
        return itemArray.count
    }
}
