//
//  MarvelAPIResponse.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 19/5/23.
//

import Foundation

struct MarvelAPIResponse: Decodable {
    let data: MarvelAPIData
}

struct MarvelAPIData: Decodable {
    let results: [MarvelHero]
    
}
struct MarvelHero: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: MarvelImage
    
}

struct MarvelImage: Decodable
{
    let path: String
    let fileExtension: String //
    
    private enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}


