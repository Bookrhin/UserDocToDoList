//
//  TodoListModel.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import Foundation

struct TodoListModel : Codable {
    let todo : [TodoModel]
    let user : [UserModel]
}

