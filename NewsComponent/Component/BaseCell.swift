//
//  BaseCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/6/22.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TableCell: UITableViewCell {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
}
