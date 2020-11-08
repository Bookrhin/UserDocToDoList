//
//  ViewController.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import UIKit

class TodoListViewController: UIViewController {
    var todoListData = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

extension TodoListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension TodoListViewController {
    func getData() {
        let urlString = "https://gist.githubusercontent.com/nRewik/0975638ea3544b91298234b590078b1e/raw/9b021fd634b0e1af5464069c7c17b57fb0295a2b/todos_and_users.json"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                if let jsonData = try? decoder.decode(TodoListModel.self, from: data) {
                    todoListData = jsonData.user
//                    tableView.reloadData()
                }
            }
        }
    }
}
