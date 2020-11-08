//
//  UserTableViewCell.swift
//  UserDocument
//
//  Created by Natthanan Gumyan on 8/11/20.
//

import UIKit
import Kingfisher
class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(userName: String, date: String, userImg: String) {
        self.userImg.kf.setImage(with: URL(string: userImg))
        self.userNameLb.text = userName
        self.dateLb.text = date
    }
    
}
