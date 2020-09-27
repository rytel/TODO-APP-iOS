//
//  ToDoItem.swift
//  TODO APP iOS
//
//  Created by Rafał Rytel on 25/09/2020.
//

import Foundation

struct ToDoItem: Encodable, Decodable {
    var name: String?
    var category: Int?
    var date: Date?
}
