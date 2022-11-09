//
//  ContentView.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-08.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject var pokeVM = PokemonViewModel()
    @StateObject var pokeApiVM = PokemonApiViewModel()

    
    var body: some View {
        NavigationView {
            
            VStack {
                List() {
                    ForEach(pokeVM.pokemonModelList) { pokemon in
                        Text(pokemon.name)
                    }
                }
            }.onAppear {
                //pokeVM.deleteAll()
//                pokeApiVM.saveData(context: CoreDataManager.shared.viewContext)
                //pokeVM.getAllPokemons()
                pokeVM.getAllPokemonModels()
            }
            
            
//            if results.isEmpty {
//                Text("Core data empty.")
//            } else {
//                List {
//                    ForEach(results, id: \.name) { poke in
//                        if let pokeName = poke.name {
//                            Text("\(pokeName)")
//                        } else {
//                            Text("No name")
//                        }
//
//                    }
//                }
//            }
//            List {
//                ForEach(pokemons, id: \.name) { poke in
//                    Text("\(poke.name)")
//                }
                
            
//            .onAppear {
//                pokes.saveData(context: CoreDataManager.shared.viewContext)
//            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
