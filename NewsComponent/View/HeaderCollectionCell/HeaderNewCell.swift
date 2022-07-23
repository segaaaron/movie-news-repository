//
//  HeaderNewCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import UIKit

class HeaderNewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = containerView.frame.height/2
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifierNews = "HeaderNewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(model: NewsList) {
        nameLabel.text = model.name
    }
}
