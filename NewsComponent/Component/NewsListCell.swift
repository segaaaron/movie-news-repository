//
//  NewsListCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/7/22.
//

import UIKit

class NewsListCell: TableCell {
    
    lazy var containerView: UIView = {
       let container = UIView()
        container.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize(width: -3, height: 10)
        container.layer.shadowRadius = 2.5
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.cornerRadius = 15
        container.layer.masksToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var movieImage: UIImageView = {
       let movieImage = UIImageView()
        movieImage.contentMode = .scaleToFill
        movieImage.layer.cornerRadius = 8
        movieImage.image = UIImage(named: "")
        movieImage.layer.masksToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .red
        label.numberOfLines = 0
        label.text = ""
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupUI()
        setupContainerChild()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor.rgb(red: 250, green: 250, blue: 250)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func setupContainerChild() {
        [movieImage, titleLabel].forEach({ containerView.addSubview($0) })
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            movieImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3),
            movieImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7),
            
            titleLabel.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
        ])
    }
    
    func configUI(model: MovieResult, index: Int) {
        titleLabel.text = model.original_title
        if let pathImage = model.poster_path {
            let currentUrl = Credencials.imagePath + pathImage
            movieImage.loadImage(with: currentUrl, name: pathImage, id: "\(index)")
        } else {
            movieImage.image = UIImage(named: "splash")
        }
    }
}
