//
//  CoreDataManager.swift
//  CoreDataLecture3
//
//  Created by Fredrik Kypta on 2022-11-07.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private var pokemons: [PokemonJSON] = PokemonJSON.allPokemonsJSON
    
    static let shared = CoreDataManager()

    var persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func getAllPokemonsFromCoreData() -> [Pokemon] {
        let request = Pokemon.fetchRequest()

        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error when fetching.")
            return []
        }
    }
    
    func getPokemonByName(name: String) -> [Pokemon] {
        let request = Pokemon.fetchRequest()
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(Pokemon.name), name
        )
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error when fetching Pokemon.")
            return [Pokemon]()
        }
    }
    
    func save() {
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
        
    }
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "AppData")
        
        persistentContainer.loadPersistentStores {
            description, error in
            
            if let error = error {
                print("Error: \(error) ")
                return
            }
        }
        
    }
    
}
