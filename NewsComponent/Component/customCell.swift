//
//  customCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/7/22.
//

import UIKit

class CustomCell: UICollectionViewCell {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    static func anyClass() -> AnyClass  { return CustomCell.self }
    
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
