//
//  MarvelDetailsModel.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

struct MarvelDetailsModel {
    let marvelImage:String
    let marvelName:String
    let marvelDescription:String
    let marvelComics:[MarvelDetailsCellModel]
    let marvelSeries:[MarvelDetailsCellModel]
    let marvelStories:[MarvelDetailsCellModel]
    let marvelEvents:[MarvelDetailsCellModel]
}
