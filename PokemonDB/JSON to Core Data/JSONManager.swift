//
//  JSONManager.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-08.
//

import Foundation
import SwiftUI
import CoreData

struct PokemonJSON: Codable, Identifiable {
    let attack, defense: Int
    let description: String
    let evolutionChain: [EvolutionChain]?
    let height, id: Int
    let imageURL: String
    let name, type: String
    let weight: Int
    let altDefense: Int?

    enum CodingKeys: String, CodingKey {
        case attack, defense
        case description
        case evolutionChain, height, id
        case imageURL = "imageUrl"
        case name, type, weight
        case altDefense = "defense:"
    }
    
    static let allPokemonsJSON: [PokemonJSON] = Bundle.main.decode(file: "pokemons.json")
    static let samplePokemonJSON: PokemonJSON = allPokemonsJSON[0]
}

struct EvolutionChain: Codable {
    let id, name: String
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project.")
        }
        
        return loadedData
    }
}
