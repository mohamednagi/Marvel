//
//  MarvelDetailsRepository.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

class MarvelDetailsRepository {
    
    
    
    /// getting marvel's derails
    ///
    /// - Parameters:
    ///   - characterID: getting details depend on character's id
    ///   - completionHandler: capturing value to pass to VM
    func getMarvelDetails(characterID:String,completionHandler: @escaping (_ array:[MarvelDetailsModel]) -> ()) {

        let group = DispatchGroup()
        ServiceLayer.shared().getData(fullUrl: baseUrl + "v1/public/characters/\(characterID)", parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey]) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                case 200:
                    print("good to go")
                default:
                    return
                }
            }
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
                    //                    semaphore.signal()
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
                        group.enter()
                        
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
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                            group.leave()
                        })
                    }
                    
                    guard let series = result["series"] as? [String:Any] else {return}
                    let seriesItems = series["items"] as? [[String:String]] ?? []
                    for singleSeries in seriesItems {
                        group.enter()
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
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                            group.leave()
                        })
                    }
                    guard let stories = result["stories"] as? [String:Any] else {return}
                    let storyItems = stories["items"] as? [[String:String]] ?? []
                    for story in storyItems {
                        group.enter()
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
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                            group.leave()
                        })
                    }
                    
                    guard let events = result["events"] as? [String:Any] else {return}
                    let eventItems = events["items"] as? [[String:String]] ?? []
                    for event in eventItems {
                        group.enter()
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
                            group.leave()
                        })
                    }
                    group.notify(queue: .main) {
                        completionHandler(detailsHolder)
                    }
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
