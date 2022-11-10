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
    
    init() {
        getAllPokemonModels()
    }
    
    func deletePokemon(pokemon: Pokemon) {
        CoreDataManager.shared.viewContext.delete(pokemon)
        save()
    }
    
    // Was used when testing initial core data DB.
    func deleteAll() {
        pokemonList.forEach { poke in
            CoreDataManager.shared.viewContext.delete(poke)
            save()
        }
    }
    
    // Was used when initializing core data DB from data in JSON-format.
    func getAllPokemons() {
        pokemonList = CoreDataManager.shared.getAllPokemonsFromCoreData()
    }
    
    func getAllPokemonModels() {
        pokemonModelList = CoreDataManager.shared.getAllPokemonsFromCoreData().map {p in
            let poke = PokemonModel(isFav: p.favorite, id: Int(p.id), name: p.name ?? "No Name", imageURL: p.imageURL ?? "No URL", type: p.type ?? "No type", description: p.descript ?? "No description", attack: Int(p.attack), defense: Int(p.defense), height: Int(p.height), weight: Int(p.weight))
            return poke
        }
    }
    
    func addFavorite(pokemon: PokemonModel) {
        if let poke = CoreDataManager.shared.getPokemonByName(name: pokemon.name).first {
            poke.favorite.toggle()
        }
        save()
        getAllPokemonModels()
    }
    
//    func filterPokemons(searchBarText: String) -> [PokemonModel] {
//        if searchBarText == "" {
//            return pokemonModelList
//        }
//        return pokemonModelList.filter {
//            $0.name.lowercased().contains(searchBarText.lowercased())
//        }
//    }
    
    let SAMPLE_POKEMON = PokemonModel(isFav: false, id: 0, name: "Bulbasaur", imageURL: "", type: "poison", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation...", attack: 35, defense: 50, height: 10, weight: 88)
    
    func save() {
        
        CoreDataManager.shared.save()
        
    }
    
}

struct PokemonModel: Identifiable {
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
    
    var typeColor: Color {
        switch type {
        case "fire":
            return Color(.systemRed)
        case "poison":
            return Color(.systemGreen)
        case "water":
            return Color(.systemBlue)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPurple)
        case "normal":
            return Color(.systemOrange)
        case "ground":
            return Color(.systemBrown)
        case "flying":
            return Color(.systemBlue)
        case "fairy":
            return Color(.systemPink)
        default:
            return Color(.systemIndigo)
        }
    }
    
}
