//
//  MarvelDetailsRepository.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

class MarvelDetailsRepository {
    
    func getMarvelDetails(characterID:String,completionHandler: @escaping (_ array:[MarvelDetailsModel]) -> ()) {
        ServiceLayer.shared().getData(url: "v1/public/characters/\(characterID)", parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey]) { (data, _, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return}
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                
                var detailsHolder = [MarvelDetailsModel]()
                var comicsHolder = [MarvelDetailsCellModel]()
                var seriesHolder = [MarvelDetailsCellModel]()
                var storiesHolder = [MarvelDetailsCellModel]()
                var eventsHolder = [MarvelDetailsCellModel]()
                
                guard let data = json["data"] as? [String:Any] else {return}
                
                let results = data["results"] as? [[String:Any]] ?? []
                for result in results {
                    let name = result["name"] as? String ?? ""
                    let characterDescription = result["description"] as? String ?? ""
                    let thumbnail = result["thumbnail"] as? [String:String] ?? [:]
                    let imagePath = thumbnail["path"] ?? ""
                    let imageExtension = thumbnail["extension"] ?? ""
                    
                    guard let comics = result["comics"] as? [String:Any] else {return}
                    let comicsItems = comics["items"] as? [[String:String]] ?? []
                    for comic in comicsItems {
                        let comicName = comic["name"] ?? ""
                        let comicImage = comic["resourceURI"] ?? ""
                        let object = MarvelDetailsCellModel(cellName: comicName, cellImage: comicImage)
                        comicsHolder.append(object)
                    }
                    
                    guard let series = result["series"] as? [String:Any] else {return}
                    let seriesItems = series["items"] as? [[String:String]] ?? []
                    for singleSeries in seriesItems {
                        let seriesName = singleSeries["name"] ?? ""
                        let seriesImage = singleSeries["resourceURI"] ?? ""
                        let object = MarvelDetailsCellModel(cellName: seriesName, cellImage: seriesImage)
                        seriesHolder.append(object)
                    }
                    
                    guard let stories = result["stories"] as? [String:Any] else {return}
                    let storyItems = stories["items"] as? [[String:String]] ?? []
                    for story in storyItems {
                        let storyName = story["name"] ?? ""
                        let storyImage = story["resourceURI"] ?? ""
                        let object = MarvelDetailsCellModel(cellName: storyName, cellImage: storyImage)
                        storiesHolder.append(object)
                    }
                    
                    guard let events = result["events"] as? [String:Any] else {return}
                    let eventItems = events["items"] as? [[String:String]] ?? []
                    for event in eventItems {
                        let eventName = event["name"] ?? ""
                        let eventImage = event["resourceURI"] ?? ""
                        let object = MarvelDetailsCellModel(cellName: eventName, cellImage: eventImage)
                        eventsHolder.append(object)
                    }
                    
                    let detailsObject = MarvelDetailsModel(marvelImage: imagePath + "." + imageExtension, marvelName: name, marvelDescription: characterDescription, marvelComics: comicsHolder, marvelSeries: seriesHolder, marvelStories: storiesHolder, marvelEvents: eventsHolder)
                    detailsHolder.append(detailsObject)
                }
                completionHandler(detailsHolder)
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
