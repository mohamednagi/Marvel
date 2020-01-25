//
//  DetailsViewModel.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

class DetailsViewModel: BaseViewModel {
    
    var marvelDetailsRepository = MarvelDetailsRepository()
    
    func getDetailsData(characterID:String) {
        marvelDetailsRepository.getMarvelDetails(characterID: characterID) { (returnedJson) in
            DispatchQueue.main.async {
                self.view.onDataRecieved(data: returnedJson as AnyObject)
            }
        }
    }
}
