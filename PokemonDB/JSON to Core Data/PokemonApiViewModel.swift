//
//  PokemonApiViewModel.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-08.
//

import SwiftUI
import CoreData

class PokemonApiViewModel: ObservableObject {
    
    @Published var pokemons: [PokemonJSON] = PokemonJSON.allPokemonsJSON
    
    func saveData(context: NSManagedObjectContext) {
        pokemons.forEach { poke in
            
            let entity = Pokemon(context: context)
            entity.name = poke.name
            entity.id = Int16(poke.id)
            entity.descript = poke.description
            entity.type = poke.type
            entity.imageURL = poke.imageURL
            entity.attack = Int16(poke.attack)
            entity.defense = Int16(poke.defense)
            entity.weight = Int16(poke.weight)
            entity.height = Int16(poke.height)
            entity.favorite = false
            
            
        }
        
        do {
            try context.save()
            print("Success")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
