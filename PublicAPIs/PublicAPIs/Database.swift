//
//  Database.swift
//  PublicAPIs
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let entries: [Database]
}

struct Database: Decodable {
    let title: String
    let description: String
    let auth: String
    let requiresHTTPS: Bool
    let cors: String
    let link: String
    let category: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "API"
        case description = "Description"
        case auth = "Auth"
        case requiresHTTPS = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}
