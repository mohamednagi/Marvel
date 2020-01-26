//
//  MarvelDetailsModel.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

/// main marvel's details model
struct MarvelDetailsModel {
    let marvelImage:String
    let marvelName:String
    let marvelDescription:String
    var marvelComics:[MarvelDetailsCellModel]
    var marvelSeries:[MarvelDetailsCellModel]
    var marvelStories:[MarvelDetailsCellModel]
    var marvelEvents:[MarvelDetailsCellModel]
    var detailLink:String
    var wikiLink:String
    var comicLink:String
}
