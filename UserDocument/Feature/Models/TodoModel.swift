//
//  TodoModel.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import Foundation
struct TodoModel : Decodable {
    var id: String
    var title: String
    var description: String
    var userId: String
    var createdAt: String
}
