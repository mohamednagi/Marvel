//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    var marvelListRepository = MarvelListRepository()
    
    func getHomeData() {
        marvelListRepository.getMarvelList { (returnedJson) in
            DispatchQueue.main.async {
                self.view.onDataRecieved(data: returnedJson as AnyObject)
            }
        }
    }
}
