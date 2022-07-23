//
//  MenuBar.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/6/22.
//

import UIKit

protocol NewsMenuBar: AnyObject {
    func scrollToMenuIndexDelegate(menuIndex: Int)
}

final class MenuBar: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var menuList: [NewsList] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: NewsMenuBar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifierCell)
        setupConstrains()
    }
    
    func setupConstrains() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func selectMenuSectionToShow(index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let selectedIndexPath = IndexPath(item: index, section: 0)
            self.collectionView.contentOffset.x = self.frame.width * CGFloat(index/4)
            self.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
            self.delegate?.scrollToMenuIndexDelegate(menuIndex: index)
        }
    }
}
extension MenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifierCell, for: indexPath) as? MenuCell else {
            return UICollectionViewCell()
        }
        let menuName = menuList[indexPath.item]
        cell.config(name: menuName.name)
        return cell
    }
}
extension MenuBar: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = menuList[indexPath.item].name.width(withConstrainedHeight: 35, font: UIFont.systemFont(ofSize: 12))
        return CGSize(width: width + 35, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.scrollToMenuIndexDelegate(menuIndex: indexPath.item)
    }
}
