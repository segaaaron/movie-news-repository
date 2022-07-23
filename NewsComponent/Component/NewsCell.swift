//
//  NewsCell.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/6/22.
//

import UIKit

class NewsCell: CustomCell {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    static var identifierCell = "NewsCell"
    
    var movieList: [MovieResult] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func setupViews() {
        setupUI()
    }
    
    func setupUI() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 180
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.identifier)
        
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configUI(identified: String, index: Int) {
        loadMovie(query: identified)
    }

    private func loadMovie(query: String) {
        var params: [String: String] = [:]
        params["api_key"] = Credencials.apikey
        params["language"] = Credencials.language
        params["query"] = query
        params["page"] = Credencials.defaultPage
        Network.callService(with: .GET, model: MovieGT.self, endPoint: .search, parameters: params) { [weak self] resul in
            switch resul {
            case .success(let list):
                self?.movieList = list.results
            case .failure(let error):
                print(error.localizedDescription)
            case .none: break
            }
        }
    }
}

extension NewsCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.identifier, for: indexPath) as? NewsListCell else {
            return UITableViewCell()
        }
        let model = movieList[indexPath.item]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.configUI(model: model, index: indexPath.item)
        return cell
    }
}
