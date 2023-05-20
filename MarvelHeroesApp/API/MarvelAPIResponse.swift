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
    let name: String
    let description: String
}
