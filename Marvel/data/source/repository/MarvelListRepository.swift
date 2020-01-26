//
//  MarvelListrepository.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

class MarvelListRepository {
    
    /// getting marvel's home characters
    ///
    /// - Parameters:
    ///   - offset: number of page for pagination
    ///   - completionHandler: capturing value to pass
    func getMarvelList(offset:Int, completionHandler: @escaping (_ array:[MarvelModel]) -> ()) {
        ServiceLayer.shared().getData(fullUrl: baseUrl + "v1/public/characters", parameters: ["apikey":publicKey,"ts":ts,"hash":hashKey,"offset":offset]) { (data, _, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return}
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                var dataArrayHolder = [MarvelModel]()
                guard let data = json["data"] as? [String:Any] else {return}
                let limit = data["limit"] as? Int ?? 0
                let total = data["total"] as? Int ?? 0
                let results = data["results"] as? [[String:Any]] ?? []
                for result in results {
                    let id = result["id"] as? Int ?? -1
                    let name = result["name"] as? String ?? ""
                    let thumbnail = result["thumbnail"] as? [String:String] ?? [:]
                    let imagePath = thumbnail["path"] ?? ""
                    let imageExtension = thumbnail["extension"] ?? ""
                    let object = MarvelModel(marvelID: id, marvelTitle: name, marvelImage: imagePath + "." + imageExtension, limit: limit, total:total)
                    dataArrayHolder.append(object)
                }
                completionHandler(dataArrayHolder)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
