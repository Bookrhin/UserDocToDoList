//
//  ViewController.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import UIKit
import Alamofire

class TodoListViewController: UIViewController {
    
    struct Constants {
        static let userTabelViewCell = "UserTableViewCell"
        static let userCell = "userCell"
        static let informationDetail = "go-to-detail"
        static let searchView = "go-to-searchView"
    }
    
    var userData = [UserModel]()
    var todoData = [TodoModel]()
    
    @IBOutlet weak var userTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setUpTableView()
        self.fethData()
        
//        self.getData()
        // Do any additional setup after loading the view.
    }
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "To Do List"
    }
    func setUpTableView() {
        self.userTableview.register(UINib(nibName: Constants.userTabelViewCell, bundle: nil), forCellReuseIdentifier: Constants.userCell)
        self.userTableview.delegate = self
        self.userTableview.dataSource = self
    }
    
    @IBAction func gotoSearchView(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.searchView, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataSender = sender as? TodoListDetailModel ,
               segue.identifier == Constants.informationDetail,
               let vc = segue.destination as? TodoDetailViewController {
            vc.detailData = dataSender
        }else if let vc = segue.destination as? SearchViewController {
            vc.userData = self.userData
            vc.todoData = self.todoData
        }
    }
}

extension TodoListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = todoData[indexPath.item]
        let userName : String = userData.filter{$0.id == data.userId}.first?.name ?? ""
        let userImg : String = userData.filter{$0.id == data.userId}.first?.avatar ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCell, for: indexPath) as! UserTableViewCell
        cell.setUpCell(userName: userName, date: data.createdAt, userImg: userImg)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = todoData[indexPath.item]
        let userName : String = userData.filter{$0.id == data.userId}.first?.name ?? ""
        let userImg : String = userData.filter{$0.id == data.userId}.first?.avatar ?? ""
        let detaildate = TodoListDetailModel(userName: userName,
                                             title: data.title,
                                             dateTimeCreate: data.createdAt,
                                             description: data.description,
                                             userImg: userImg)
        self.performSegue(withIdentifier: Constants.informationDetail, sender: detaildate)
    }
    
   
}

extension TodoListViewController {
    
    func fethData() {
        // change json file endpoint here
        let request = AF.request("https://gist.githubusercontent.com/nRewik/0975638ea3544b91298234b590078b1e/raw/9b021fd634b0e1af5464069c7c17b57fb0295a2b/todos_and_users.json")
        request.responseDecodable(of: TodoListModel.self) { (response) in
            guard let data = response.value else { return }
            self.userData = data.user
            self.todoData = data.todo
            self.userTableview.reloadData()
        }
    }
    
}
