//
//  TodoListDetailModel.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 9/11/20.
//

import Foundation
struct TodoListDetailModel {
    
    var userName : String
    var title : String
    var dateTimeCreate: String
    var description: String
    var userImg : String
    
    init (userName: String , title :String, dateTimeCreate: String , description : String ,userImg :String) {
        self.userName = userName
        self.title = title
        self.dateTimeCreate = dateTimeCreate
        self.description = description
        self.userImg = userImg
    }
    
}
