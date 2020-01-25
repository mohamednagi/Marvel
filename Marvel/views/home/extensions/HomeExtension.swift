//
//  HomeExtension.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case marvelSearchList:
            return marvelSearchArray.count
        default:
            return homeMarvelArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case marvelSearchList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelSearchCell", for: indexPath) as? MarvelSearchCell else {return UITableViewCell()}
            cell.searchName.text = marvelSearchArray[indexPath.row].marvelTitle
            let url = URL(string: (marvelSearchArray[indexPath.row].marvelImage))
            cell.searchImage?.kf.indicatorType = .activity
            cell.searchImage?.kf.setImage(with: url)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMarvelCell", for: indexPath) as? HomeMarvelCell else {return UITableViewCell()}
            cell.marvelName.text = homeMarvelArray[indexPath.row].marvelTitle
            let url = URL(string: (homeMarvelArray[indexPath.row].marvelImage))
            cell.marvelImage?.kf.indicatorType = .activity
            cell.marvelImage?.kf.setImage(with: url)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case marvelSearchList:
            return 50
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let marvelDetailsView = storyBoard.instantiateViewController(withIdentifier: "MarvelDetailsView") as? MarvelDetailsView else {return}
        switch tableView {
        case marvelSearchList:
            marvelDetailsView.characterID = String(marvelSearchArray[indexPath.row].marvelID)
        default:
            marvelDetailsView.characterID = String(homeMarvelArray[indexPath.row].marvelID)
        }
        navigationController?.pushViewController(marvelDetailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == homeMarvelList {
        if indexPath.row == homeMarvelArray.count - 2 {
            let result = Double(Double(total) / 20.0).rounded(.up)
            
            if homeMarvelArray.count < total && (Double(offset) <= result) {
                limit += 20
                offset = (offset) + 1
//                if Double(offset) <= result {
                    // handlePagination(page: String(page ?? 1))
//                    print("fetch more")
                    print("offset",offset)
                    viewModel.getHomeData(offset: offset)
//                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        }
        }
    }
    
    @objc func loadTable() {
        homeMarvelList.reloadData()
    }
}

extension HomeView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchAction()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearchAction()
    }
    
    func handleSearchAction() {
        if searchBar.text == "" {
            searchListHeightConstraint.constant = 0
            searchBar.resignFirstResponder()
        }else {
            let searchText = searchBar.text
            marvelSearchArray = homeMarvelArray.filter{$0.marvelTitle.contains("\(searchText!)")}
            if marvelSearchArray.count < 10 {
                searchListHeightConstraint.constant = CGFloat(marvelSearchArray.count * 50)
            }else {
                searchListHeightConstraint.constant = 500
            }
            marvelSearchList.reloadData()
        }
    }
}
