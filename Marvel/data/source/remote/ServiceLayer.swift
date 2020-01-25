//
//  ServiceLayer.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import Foundation

let baseUrl = "https://gateway.marvel.com:443/"
let publicKey = "aadaf879c9efcb5b895f4f2171486969"
let hashKey = "41ca4ad67a2264e288e4058dc410224e"
//let privateKey = "c1de03f89b32353ced4b52623f302129f9c13275"
let ts = "Mohamed Nagi"

class ServiceLayer {
    
    private static let sharedInstance = ServiceLayer()
    
    private init() {}
    
    static func shared() -> ServiceLayer {
        return sharedInstance
    }
    
    
    func getData(url:String, parameters: [String:Any], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var components = URLComponents(string: baseUrl+url) ?? URLComponents()
        components.queryItems = parameters.map { (arg) -> URLQueryItem in
            let (key, value) = arg
            return URLQueryItem(name: key, value: value as? String)
        }
        
        var request = URLRequest(url: components.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}
