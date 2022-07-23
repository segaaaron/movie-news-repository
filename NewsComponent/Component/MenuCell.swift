//
//  MenuCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/6/22.
//

import UIKit

class MenuCell: BaseCell {
    lazy private var container: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.rgb(red: 255, green: 0, blue: 190)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifierCell = "MenuCell"
    
    override var isSelected: Bool {
        didSet {
            container.layer.cornerRadius = isSelected ? container.frame.height/2 : 0
            container.backgroundColor = isSelected ? UIColor.rgb(red: 255, green: 204, blue: 242) : UIColor.clear
        }
    }
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        setupContrains()
    }
    
    func setupContrains() {
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
        
        container.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        layoutIfNeeded()
        stackView.addArrangedSubview(nameLabel)
    }
    
    func config(name: String) {
        nameLabel.text = name
    }
}
