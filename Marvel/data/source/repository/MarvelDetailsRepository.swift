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
        ServiceLayer.shared().getData(fullUrl: baseUrl + "v1/public/characters/\(characterID)", parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey]) { (data, _, error) in
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
                    
                    var detailLink = ""
                    var wikiLink = ""
                    var comicLink = ""
                    
                    let urls = result["urls"] as? [[String:String]] ?? []
                    for url in urls {
                        let linkType = url["type"] ?? ""
                        switch linkType {
                        case "detail":
                            detailLink = url["url"] ?? ""
                        case "wiki":
                            wikiLink = url["url"] ?? ""
                        default:
                            comicLink = url["url"] ?? ""
                        }
                        let object = MarvelDetailsModel(marvelImage: imagePath + "." + imageExtension, marvelName: name, marvelDescription: characterDescription, marvelComics: comicsHolder, marvelSeries: seriesHolder, marvelStories: storiesHolder, marvelEvents: eventsHolder, detailLink: detailLink, wikiLink: wikiLink, comicLink: comicLink)
                        detailsHolder.append(object)
                    }
                    
                    guard let comics = result["comics"] as? [String:Any] else {return}
                    let comicsItems = comics["items"] as? [[String:String]] ?? []
                    for comic in comicsItems {
                        let comicName = comic["name"] ?? ""
                        let comicURI = comic["resourceURI"] ?? ""
                        
                        ServiceLayer.shared().getData(fullUrl: comicURI, parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey], completion: { (data, _, error) in
                            guard let data = data, error == nil else {
                                print(error?.localizedDescription as Any)
                                return}
                            do {
                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                                guard let data = json["data"] as? [String:Any] else {return}
                                let results = data["results"] as? [[String:Any]] ?? []
                                for result in results {
                                    let thumbnail = result["thumbnail"] as? [String:String] ?? [:]
                                    let imagePath = thumbnail["path"] ?? ""
                                    let imageExtension = thumbnail["extension"] ?? ""
                                    let comicImage = imagePath + "." + imageExtension
                                    let object = MarvelDetailsCellModel(cellName: comicName, cellImage: comicImage)
                                    comicsHolder.append(object)
                                }
                                if !comicsHolder.isEmpty {
                                let detailsObject = MarvelDetailsModel(marvelImage: imagePath + "." + imageExtension, marvelName: name, marvelDescription: characterDescription, marvelComics: comicsHolder, marvelSeries: seriesHolder, marvelStories: storiesHolder, marvelEvents: eventsHolder, detailLink: detailLink, wikiLink: wikiLink, comicLink: comicLink)
                                detailsHolder.append(detailsObject)
                                completionHandler(detailsHolder)
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                        })
                        
                    }
                    guard let series = result["series"] as? [String:Any] else {return}
                    let seriesItems = series["items"] as? [[String:String]] ?? []
                    for singleSeries in seriesItems {
                        let seriesName = singleSeries["name"] ?? ""
                        let seriesURI = singleSeries["resourceURI"] ?? ""
                        
                        ServiceLayer.shared().getData(fullUrl: seriesURI, parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey], completion: { (data, _, error) in
                            guard let data = data, error == nil else {
                                print(error?.localizedDescription as Any)
                                return}
                            do {
                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                                guard let data = json["data"] as? [String:Any] else {return}
                                let results = data["results"] as? [[String:Any]] ?? []
                                for result in results {
                                    let thumbnail = result["thumbnail"] as? [String:String] ?? [:]
                                    let imagePath = thumbnail["path"] ?? ""
                                    let imageExtension = thumbnail["extension"] ?? ""
                                    let seriesImage = imagePath + "." + imageExtension
                                    let object = MarvelDetailsCellModel(cellName: seriesName, cellImage: seriesImage)
                                    seriesHolder.append(object)
                                }
                                if !seriesHolder.isEmpty {
                                let detailsObject = MarvelDetailsModel(marvelImage: imagePath + "." + imageExtension, marvelName: name, marvelDescription: characterDescription, marvelComics: comicsHolder, marvelSeries: seriesHolder, marvelStories: storiesHolder, marvelEvents: eventsHolder, detailLink: detailLink, wikiLink: wikiLink, comicLink: comicLink)
                                detailsHolder.append(detailsObject)
                                completionHandler(detailsHolder)
                                    
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                        })
                        
                    }
                    guard let stories = result["stories"] as? [String:Any] else {return}
                    let storyItems = stories["items"] as? [[String:String]] ?? []
                    for story in storyItems {
                        let storyName = story["name"] ?? ""
                        let storyURI = story["resourceURI"] ?? ""
                        ServiceLayer.shared().getData(fullUrl: storyURI, parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey], completion: { (data, _, error) in
                            guard let data = data, error == nil else {
                                print(error?.localizedDescription as Any)
                                return}
                            do {
                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                                guard let data = json["data"] as? [String:Any] else {return}
                                let results = data["results"] as? [[String:Any]] ?? []
                                for result in results {
                                    let thumbnail = result["thumbnail"] as? [String:String] ?? [:]
                                    let imagePath = thumbnail["path"] ?? ""
                                    let imageExtension = thumbnail["extension"] ?? ""
                                    let storiesImage = imagePath + "." + imageExtension
                                    let object = MarvelDetailsCellModel(cellName: storyName, cellImage: storiesImage)
                                    storiesHolder.append(object)
                                }
                                if !storiesHolder.isEmpty {
                                let detailsObject = MarvelDetailsModel(marvelImage: imagePath + "." + imageExtension, marvelName: name, marvelDescription: characterDescription, marvelComics: comicsHolder, marvelSeries: seriesHolder, marvelStories: storiesHolder, marvelEvents: eventsHolder, detailLink: detailLink, wikiLink: wikiLink, comicLink: comicLink)
                                detailsHolder.append(detailsObject)
                                completionHandler(detailsHolder)
                                    
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                        })
                        
                    }
                    guard let events = result["events"] as? [String:Any] else {return}
                    let eventItems = events["items"] as? [[String:String]] ?? []
                    for event in eventItems {
                        let eventName = event["name"] ?? ""
                        let enevtURI = event["resourceURI"] ?? ""
                        ServiceLayer.shared().getData(fullUrl: enevtURI, parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey], completion: { (data, _, error) in
                            guard let data = data, error == nil else {
                                print(error?.localizedDescription as Any)
                                return}
                            do {
                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                                guard let data = json["data"] as? [String:Any] else {return}
                                let results = data["results"] as? [[String:Any]] ?? []
                                for result in results {
                                    let thumbnail = result["thumbnail"] as? [String:String] ?? [:]
                                    let imagePath = thumbnail["path"] ?? ""
                                    let imageExtension = thumbnail["extension"] ?? ""
                                    let eventsImage = imagePath + "." + imageExtension
                                    let object = MarvelDetailsCellModel(cellName: eventName, cellImage: eventsImage)
                                    eventsHolder.append(object)
                                }
                                if !eventsHolder.isEmpty {
                                let detailsObject = MarvelDetailsModel(marvelImage: imagePath + "." + imageExtension, marvelName: name, marvelDescription: characterDescription, marvelComics: comicsHolder, marvelSeries: seriesHolder, marvelStories: storiesHolder, marvelEvents: eventsHolder, detailLink: detailLink, wikiLink: wikiLink, comicLink: comicLink)
                                detailsHolder.append(detailsObject)
                                completionHandler(detailsHolder)
                                    
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                        })
                    }
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
