//
//  NewsContainer.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/6/22.
//

import UIKit

final class NewsContainer: UIViewController {
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.delegate = self
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    var menuList: [NewsList] = []
    var movieList: [MovieResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NOTICIAS"
        view.backgroundColor = UIColor.rgb(red: 250, green: 250, blue: 250)
        setupBarMenu()
        setupConstrains()
        scrollToMenuIndex(menuIndex: 7)
        menuBar.menuList = MenuListMock.list
    }
    func setupBarMenu() {
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            menuBar.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    func setupConstrains() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifierCell)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        DispatchQueue.main.async {
            let selectedIndexPath = IndexPath(item: menuIndex, section: 0)
            self.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
            self.menuBar.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}

extension NewsContainer: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifierCell, for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
        let identifierList = ["batman", "superman", "world", "car", "accion", "drama", "comedy", "lake", "disney", "wonder"]
        
        cell.configUI(identified: identifierList[indexPath.item], index: indexPath.item)
        return cell
    }
}

extension NewsContainer: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / (view.frame.width - 40))
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension NewsContainer: NewsMenuBar {
    func scrollToMenuIndexDelegate(menuIndex: Int) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: menuIndex, section: 0)
            self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        }
    }
}
