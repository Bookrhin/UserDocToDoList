//
//  SearchViewController.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 9/11/20.
//

import UIKit
import Kingfisher
import RxSwift
import RxDataSources
class SearchViewController: UIViewController {
    
    struct Constants {
        static let userTabelViewCell = "UserTableViewCell"
        static let userCell = "userCell"
        static let informationDetail = "go-to-detail"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userTableview: UITableView!
    var userData : [UserModel] = []
    var todoData : [TodoModel] = []
    var arrayInfomation : [TodoModel] = []
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setUpTableView()
        self.setUpSearchBar()
        // Do any additional setup after loading the view.
    }
    
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let backbtn  = UIBarButtonItem(title: "Back to List", style: .plain, target: self, action: #selector(backToMain))
        self.navigationItem.leftBarButtonItem = backbtn
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpSearchBar() {
        self.searchBar.autocapitalizationType = .none
        self.searchBar
            .rx
            .text
            .distinctUntilChanged()
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] (text) in
                guard let self = self else {return}
                guard let text = text , !text.isEmpty else {
                    self.clearSearchResult()
                    return
                }
                self.arrayInfomation = self.todoData.filter {$0.title.contains(text)}
                self.userTableview.reloadData()
            }).disposed(by: self.disposeBag)
    }
    
    func clearSearchResult() {
        self.arrayInfomation = []
        self.userTableview.reloadData()
    }
    
    func setUpTableView() {
        self.userTableview.register(UINib(nibName: Constants.userTabelViewCell, bundle: nil), forCellReuseIdentifier: Constants.userCell)
        self.userTableview.delegate = self
        self.userTableview.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataSender = sender as? TodoListDetailModel ,
               segue.identifier == Constants.informationDetail,
               let vc = segue.destination as? TodoDetailViewController{
            vc.detailData = dataSender
        }
    }
    

}
extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInfomation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrayInfomation[indexPath.item]
        let userName : String = userData.filter{$0.id == data.userId}.first?.name ?? ""
        let userImg : String = userData.filter{$0.id == data.userId}.first?.avatar ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCell, for: indexPath) as! UserTableViewCell
        cell.setUpCell(userName: userName, date: data.createdAt, userImg: userImg)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = arrayInfomation[indexPath.item]
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
