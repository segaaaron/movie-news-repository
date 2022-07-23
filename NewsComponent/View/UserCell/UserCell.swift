//
//  UserCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    static let identifierUser = "UserCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func config(model: User) {
        nameLabel.text = model.name
        userNameLabel.text = model.username
        emailLabel.text = model.email
        phoneLabel.text = model.phone
        websiteLabel.text = model.website
    }
}
