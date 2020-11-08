//
//  TodoDetailViewController.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 9/11/20.
//

import UIKit
import Kingfisher
class TodoDetailViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var informationDetail: UILabel!
    
    var detailData : TodoListDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupView()
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
    
    func setupView() {
        guard let data = detailData else {
            return
        }
        self.userName.text = data.userName
        self.createDate.text = data.dateTimeCreate
        self.userImg.kf.setImage(with: URL(string: data.userImg))
        self.informationDetail.text = data.description
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
