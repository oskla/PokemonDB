//
//  PokemonViewModel.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-08.
//

import Foundation
import CoreData
import SwiftUI

class PokemonViewModel: ObservableObject {
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonModelList = [PokemonModel]()
    
    func deletePokemon(pokemon: Pokemon) {
        CoreDataManager.shared.viewContext.delete(pokemon)
        save()
    }
    
    func deleteAll() {
        pokemonList.forEach { poke in
            CoreDataManager.shared.viewContext.delete(poke)
            save()
        }
    }
    
    func getAllPokemons() {
        pokemonList = CoreDataManager.shared.getAllPokemonsFromCoreData()
    }
    
    func getAllPokemonModels() {
        pokemonModelList = CoreDataManager.shared.getAllPokemonsFromCoreData().map {p in
            let poke = PokemonModel(isFav: p.favorite, id: Int(p.id), name: p.name ?? "No Name", imageURL: p.imageURL ?? "No URL", type: p.type ?? "No type", description: p.descript ?? "No description", attack: Int(p.attack), defense: Int(p.defense), height: Int(p.height), weight: Int(p.weight))
            return poke
        }
    }
    
    func save() {
        
        CoreDataManager.shared.save()
        
        //getAllPokemons()
        
    }
    
}
//Identifiable, Decodable
struct PokemonModel: Identifiable {
    //let pokeID = UUID()
    var isFav: Bool
    
    let id: Int
    let name: String
    let imageURL: String
    let type: String
    let description: String

    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case imageURL
//        case type
//        case description = "descript"
//        case attack
//        case defense
//        case height
//        case weight
//        case isFav = "favorite"
//    }
//
//    var typeColor: Color {
//        switch type {
//        case "fire":
//            return Color(.systemRed)
//        case "poison":
//            return Color(.systemGreen)
//        case "water":
//            return Color(.systemBlue)
//        case "electric":
//            return Color(.systemYellow)
//        case "psychic":
//            return Color(.systemPurple)
//        case "normal":
//            return Color(.systemOrange)
//        case "ground":
//            return Color(.systemBrown)
//        case "flying":
//            return Color(.systemBlue)
//        case "fairy":
//            return Color(.systemPink)
//        default:
//            return Color(.systemIndigo)
//        }
//    }
    
//    init() {}
    
}
