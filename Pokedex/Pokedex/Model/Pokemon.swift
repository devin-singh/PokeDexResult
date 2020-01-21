//
//  Pokemon.swift
//  Pokedex
//
//  Created by Devin Singh on 1/21/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let baseXP: Int
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case baseXP = "base_experience"
        case sprites
    }
    
    struct Sprites: Decodable {
        
        let classic: URL
        
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        }
    }
}
