//
//  ComponentViewController.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/6/22.
//

import UIKit

class ComponentViewController: UIViewController {
    
    var paginator: NewsContainer = {
       let paginator = NewsContainer()
        return paginator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
