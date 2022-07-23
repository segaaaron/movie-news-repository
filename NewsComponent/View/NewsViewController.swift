//
//  NewsViewController.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import UIKit

class NewsViewController: UIViewController {
    private var tableView: UITableView = {
       let table = UITableView()
        table.separatorStyle = .none
        table.rowHeight = 140
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private var userList: [User] = []
    private var newsHeaderList: [NewsList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NOTICIAS"
        view.backgroundColor = UIColor.getColorWith(hex: "#FF7015")
        newsHeaderList = loadHeaderlist()
        setupLayout()
        loadUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func loadHeaderlist() -> [NewsList] {
        let news = NewsList(name: "Noticias")
        let sport = NewsList(name: "Deportes")
        let mexico = NewsList(name: "Nacionales")
        let tender = NewsList(name: "Tendencia")
        let entreteiment = NewsList(name: "Entretenimiento")
        let descatade = NewsList(name: "Destacados")
        let comedi = NewsList(name: "Comedia")
        let tragedi = NewsList(name: "Tragedia")
        let espn = NewsList(name: "ESPN")
        let funny = NewsList(name: "Humor")
        return [news, sport, mexico, tender, entreteiment, descatade, comedi, tragedi, espn, funny]
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nibChild = UINib(nibName: "HeaderNewCell", bundle: nil)
        collectionView.register(nibChild, forCellWithReuseIdentifier: HeaderNewCell.identifierNews)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserCell.identifierUser)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
            collectionView.heightAnchor.constraint(equalToConstant: 70),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
    }
    
    private func loadUser() {
        Network.callService(with: .GET, model: [User].self, endPoint: .user) { [weak self] resul in
            switch resul {
            case .success(let list):
                self?.userList = list
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            case .none: break
            }
        }
    }
}
/// TABLEVIEW DATASOURCE AND DELEGATE
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifierUser, for: indexPath) as? UserCell  else {
            return UITableViewCell()
        }
        let currentUser = userList[indexPath.row]
        cell.config(model: currentUser)
        return cell
    }
}
/// COLLECTION DATASOURCE AND DELEGATE
extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsHeaderList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderNewCell.identifierNews, for: indexPath) as? HeaderNewCell else {
            return UICollectionViewCell()
        }
        let header = newsHeaderList[indexPath.row]
        cell.config(model: header)
        return cell
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 60)
    }
}
//UITableView.automaticDimension
