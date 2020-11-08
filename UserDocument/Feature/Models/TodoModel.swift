//
//  TodoModel.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import Foundation
struct TodoModel : Codable {
    let id: String
    let title: String
    let description: String
    let userId: String
    let createdAt: String
}
