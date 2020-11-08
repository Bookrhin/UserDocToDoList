//
//  TodoListModel.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import Foundation

struct TodoListModel : Decodable {
    var todo : [TodoModel]
    var user : [UserModel]

//    enum CodingKeys: String, CodingKey {
//        case todo = "todo"
//        case user = "user"
//    }


}

