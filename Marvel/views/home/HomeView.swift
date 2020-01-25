//
//  ViewController.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit
import Kingfisher

class HomeView: UIViewController, BaseView {
    
    @IBOutlet weak var homeMarvelList: UITableView!
    @IBOutlet weak var marvelSearchList: UITableView!
    
    @IBOutlet weak var searchListHeightConstraint: NSLayoutConstraint!
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.8, height: self.view.frame.size.height * 0.5))
    lazy var searchIcon:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: self.view.frame.size.height * 0.7))
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    var viewModel: HomeViewModel!
    var homeMarvelArray = [MarvelModel]()
    var filteredHomeMarvelArray = [MarvelModel]()
    var marvelSearchArray = [MarvelModel]()
    
    var limit = 0
    var total = 0
    var offset = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlingNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(view: self)
        viewModel.getHomeData(offset: offset)
    }

    func onDataRecieved(data: AnyObject) {
        guard let returnedData = data as? [MarvelModel] else {return}
        homeMarvelArray += returnedData
        limit = homeMarvelArray.first?.limit ?? 0
        total = homeMarvelArray.first?.total ?? 0
        homeMarvelList.reloadData()
    }
    
    func handlingNavBar() {
        searchBar.delegate = self
        searchListHeightConstraint.constant = 0
        searchBar.text = ""
        navigationController?.navigationBar.barTintColor = .black
        searchBar.isHidden = true
        searchIcon.isHidden = false
        let leftNavBarButton = UIBarButtonItem(customView: searchIcon)
        searchIcon.setImage(UIImage(named: "searc"), for: .normal)
        searchIcon.addTarget(self, action: #selector(showSearchBar(sender:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [leftNavBarButton]
        
        let logo = UIImage(named: "marvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    @objc func showSearchBar(sender: UIButton) {
        searchIcon.isHidden = true
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        
        self.searchBar.alpha = 0
        self.searchBar.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.navigationItem.titleView = nil
            self.searchBar.alpha = 1
        }
        
        self.navigationItem.rightBarButtonItems = [leftNavBarButton]
            searchBar.placeholder = "Search..."
        
    }


}

