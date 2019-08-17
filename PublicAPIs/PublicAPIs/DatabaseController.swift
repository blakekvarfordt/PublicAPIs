//
//  DatabaseController.swift
//  PublicAPIs
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

class DatabaseController {
    
    static func fetchCategories(completion: @escaping ([String]) -> Void) {
        
        guard let baseURL = URL(string: "https://api.publicapis.org/categories") else { completion([]); return }
        
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print(error)
                completion([])
                return
                
            }
            guard let data = data else { completion([]); return }
            
            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(categories)
            } catch {
                
                print(error)
                print(error.localizedDescription)
                completion([])
            }
            
        }.resume()
    }
    
    static func fetchDatabases(category: String, completion: @escaping ([Database]) -> Void) {
        
        guard let baseURL = URL(string: "https://api.publicapis.org/entries") else { completion([]); return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryItem = URLQueryItem(name: "category", value: category)
        
        urlComponents?.queryItems = [queryItem]
        
        guard let finalURL = urlComponents?.url else {completion([]); return }
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                print(error.localizedDescription)
                completion([])
            }
            
            guard let data = data else { completion([]); return }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
 lnm                 let databases = topLevelObject.entries
                completion(databases)
            } catch {
                print(error)
                completion([])
            }
        }.resume()
        
    }
}
