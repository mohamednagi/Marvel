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
    
    /// passing home data to home view
    ///
    /// - Parameter offset: number of page for pagination
    func getHomeData(offset:Int) {
        marvelListRepository.getMarvelList(offset:offset) { (returnedJson) in
            DispatchQueue.main.async {
                self.view.onDataRecieved(data: returnedJson as AnyObject)
            }
        }
    }
}
