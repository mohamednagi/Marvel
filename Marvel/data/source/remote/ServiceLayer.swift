//
//  ServiceLayer.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

let baseUrl = "http://gateway.marvel.com/"
let publicKey = "aadaf879c9efcb5b895f4f2171486969"
let hashKey = "41ca4ad67a2264e288e4058dc410224e"
let ts = "Mohamed Nagi"

/// service layer for getting data from api,, singleton with private init as we discussed in our last interview
class ServiceLayer {
    
    private static let sharedInstance = ServiceLayer()
    
    private init() {}
    
    static func shared() -> ServiceLayer {
        return sharedInstance
    }
    
    
    /// general func for all get requests
    ///
    /// - Parameters:
    ///   - fullUrl: full api to fetch data
    ///   - parameters: sent parameters depend on the calling function from specific repo
    ///   - completion: capturing the result
    func getData(fullUrl:String, parameters: [String:Any], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var components = URLComponents(string: fullUrl) ?? URLComponents()
        components.queryItems = parameters.map { (arg) -> URLQueryItem in
            let (key, value) = arg
            return URLQueryItem(name: key, value: value as? String)
        }
        
        var request = URLRequest(url: components.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}
