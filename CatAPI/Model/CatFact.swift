//
//  CatFact.swift
//  CatAPI
//
//  Created by jinwoong Kim on 2023/09/21.
//

import Foundation

struct CatFact: Decodable {
    let id: String
    let version: Int
    let text: String
    let updatedAt: String
    let deleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version = "__v"
        case text, updatedAt, deleted
    }
}
