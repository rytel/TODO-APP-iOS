//
//  MainViewModel.swift
//  TODO APP iOS
//
//  Created by Rafał Rytel on 27/09/2020.
//

import Foundation

class ItemViewModel {
    let item: Item
    let name: String!
    let date: String!
    let category: String!

    init(_ toDoItem: Item) {
        self.item = toDoItem
        name = item.name
        date = String("\(item.date!)".prefix(10))
        switch item.category {
        case 0:
            category = "Praca"
        case 1:
            category = "Zakupy"
        case 2:
            category = "Inne"
        default:
            category = "Praca"
        }
        
    }
    
}

