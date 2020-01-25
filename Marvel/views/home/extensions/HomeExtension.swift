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
        return homeMarvelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMarvelCell", for: indexPath) as? HomeMarvelCell else {return UITableViewCell()}
        cell.marvelName.text = homeMarvelArray[indexPath.row].marvelTitle
        let url = URL(string: (homeMarvelArray[indexPath.row].marvelImage))
        cell.marvelImage?.kf.indicatorType = .activity
        cell.marvelImage?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let marvelDetailsView = storyBoard.instantiateViewController(withIdentifier: "MarvelDetailsView") as? MarvelDetailsView else {return}
        marvelDetailsView.characterID = String(homeMarvelArray[indexPath.row].marvelID)
        navigationController?.pushViewController(marvelDetailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == filteredHomeMarvelArray.count - 2 {
            let result = Double(Double(self.total) / 12.0).rounded(.up)
            
            if filteredHomeMarvelArray.count <= total && (Double(page ?? 1) <= result) {
                limit += 12
                self.page = (self.page ?? 1) + 1
                if Double(self.page ?? 1) <= result {
//                    handlePagination(page: String(page ?? 1))
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
    
    @objc func loadTable() {
        homeMarvelList.reloadData()
    }
}
