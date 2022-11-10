//
//  ContentView.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-08.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject var customBools = CustomBools(bools: [CustomBool(state: true, name: "fire"),CustomBool(state: true, name: "poison"), CustomBool(state: true, name: "water"),CustomBool(state: true, name: "electric"), CustomBool(state: true, name: "psychic"),CustomBool(state: true, name: "normal"), CustomBool(state: true, name: "ground"), CustomBool(state: true, name: "flying"), CustomBool(state: true, name: "fairy"), CustomBool(state: true, name: "other")])
    
    
    @StateObject var pokeVM = PokemonViewModel()
    //@StateObject var pokeApiVM = PokemonApiViewModel()
    @State private var searchBarText = ""
    @State private var showOnlyFavorites = false
    @State private var dontShowFire = false
    @State private var dontShowPoison = false
    @State private var dontShowWater = false
    @State private var dontShowElectric = false
    @State private var dontShowPsychic = false
    @State private var dontShowNormal = false
    @State private var dontShowGround = false
    @State private var dontShowFlying = false
    @State private var dontShowFairy = false
    @State private var dontShowOther = false
    

    
    var filteredPokemons: [PokemonModel] {
        var result = pokeVM.pokemonModelList
        
        if showOnlyFavorites {result = result.filter {$0.isFav}}
        if dontShowFire {result = result.filter {$0.type != "fire"}}
        if dontShowPoison {result = result.filter {$0.type != "poison"}}
        if dontShowWater {result = result.filter {$0.type != "water"}}
        if dontShowElectric {result = result.filter {$0.type != "electric"}}
        if dontShowPsychic {result = result.filter {$0.type != "psychic"}}
        if dontShowNormal {result = result.filter {$0.type != "normal"}}
        if dontShowGround {result = result.filter {$0.type != "ground"}}
        if dontShowFlying {result = result.filter {$0.type != "flying"}}
        if dontShowFairy {result = result.filter {$0.type != "fairy"}}
//        if dontShowOther {result = result.filter {["fire","poison","water", "electric","psychic","normal","ground","flying","fairy"].contains($0.type)}}
        if dontShowOther {result = result.filter {!["fighting","bug","rock","grass","ice","steel","dragon"].contains($0.type)}}
        
        
        
        if searchBarText == "" {
            return result
        }
        return result.filter {
            $0.name.lowercased().contains(searchBarText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack(spacing: 50) {
                    Button(action: {setBools(string: "All")}, label: {Label("All", systemImage: "capsule.fill")})
                    Button(action: {setBools(string: "None")}, label: {Label("None", systemImage: "capsule")})
                    Button(action: {showOnlyFavorites = !showOnlyFavorites}) {Label("Favorites", systemImage: "star.fill")}
                }
                HStack {
                    ToggleButton(onColor: Color(.systemRed), isOn: !dontShowFire, type: "Fire", function: {dontShowFire.toggle()})
                    ToggleButton(onColor: Color(.systemGreen), isOn: !dontShowPoison, type: "Poison", function: {dontShowPoison.toggle()})
                    ToggleButton(onColor: Color(.systemBlue), isOn: !dontShowWater, type: "Water", function: {dontShowWater.toggle()})
                    ToggleButton(onColor: Color(.systemYellow), isOn: !dontShowElectric, type: "Electric", function: {dontShowElectric.toggle()})
                    ToggleButton(onColor: Color(.systemPurple), isOn: !dontShowPsychic, type: "Psychic", function: {dontShowPsychic.toggle()})
                }
                .environmentObject(customBools)
                HStack {
                    ToggleButton(onColor: Color(.systemOrange), isOn: !dontShowNormal, type: "Normal", function: {dontShowNormal.toggle()})
                    ToggleButton(onColor: Color(.systemBrown), isOn: !dontShowGround, type: "Ground", function: {dontShowGround.toggle()})
                    ToggleButton(onColor: Color(.systemBlue), isOn: !dontShowFlying, type: "Flying", function: {dontShowFlying.toggle()})
                    ToggleButton(onColor: Color(.systemPink), isOn: !dontShowFairy, type: "Fairy", function: {dontShowFairy.toggle()})
                    ToggleButton(onColor: Color(.systemIndigo), isOn: !dontShowOther, type: "Other", function: {dontShowOther.toggle()})

                }
                .environmentObject(customBools)
                List { //pokeVM.pokemonModelList
                    ForEach(filteredPokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(pokemon.name.capitalized)
                                            .font(.title)
                                        if pokemon.isFav {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                    HStack {
                                        Text(pokemon.type.capitalized)
                                            .italic()
                                        Capsule()
                                            .foregroundColor(pokemon.typeColor)
                                            .frame(width: 20, height: 10)
                                    }
                                    Text(pokemon.description)
                                        .font(.caption)
                                        .lineLimit(2)
                                }
                                
                                Spacer()
                                
                                Image(pokemon.name)
                                    .resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button(action: {pokeVM.addFavorite(pokemon: pokemon)}) {
                                Image(systemName: "star")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(action: {pokeVM.addFavorite(pokemon: pokemon)}) {
                                Image(systemName: "star")
                            }
                            .tint(.yellow)
                        }
                    }
                }
                .navigationTitle("Pokémon")
                .searchable(text: $searchBarText)
//                .onAppear {
//                    //pokeVM.deleteAll()
//                    //pokeApiVM.saveData(context: CoreDataManager.shared.viewContext)
//                    //pokeVM.getAllPokemons()
//                    //pokeVM.getAllPokemonModels()
//                }
            }
            
        }
    }
    
    func setBools(string: String) {
        switch string {
        case "All":
            dontShowFire = false
            customBools.bools.first(where: {$0.name == "fire"})?.setState(bool: true)
            dontShowPoison = false
            customBools.bools.first(where: {$0.name == "poison"})?.setState(bool: true)
            dontShowWater = false
            customBools.bools.first(where: {$0.name == "water"})?.setState(bool: true)
            dontShowElectric = false
            customBools.bools.first(where: {$0.name == "electric"})?.setState(bool: true)
            dontShowPsychic = false
            customBools.bools.first(where: {$0.name == "psychic"})?.setState(bool: true)
            dontShowNormal = false
            customBools.bools.first(where: {$0.name == "normal"})?.setState(bool: true)
            dontShowGround = false
            customBools.bools.first(where: {$0.name == "ground"})?.setState(bool: true)
            dontShowFlying = false
            customBools.bools.first(where: {$0.name == "flying"})?.setState(bool: true)
            dontShowFairy = false
            customBools.bools.first(where: {$0.name == "fairy"})?.setState(bool: true)
            dontShowOther = false
            customBools.bools.first(where: {$0.name == "other"})?.setState(bool: true)
        case "None":
            dontShowFire = true
            customBools.bools.first(where: {$0.name == "fire"})?.setState(bool: false)
            dontShowPoison = true
            customBools.bools.first(where: {$0.name == "poison"})?.setState(bool: false)
            dontShowWater = true
            customBools.bools.first(where: {$0.name == "water"})?.setState(bool: false)
            dontShowElectric = true
            customBools.bools.first(where: {$0.name == "electric"})?.setState(bool: false)
            dontShowPsychic = true
            customBools.bools.first(where: {$0.name == "psychic"})?.setState(bool: false)
            dontShowNormal = true
            customBools.bools.first(where: {$0.name == "normal"})?.setState(bool: false)
            dontShowGround = true
            customBools.bools.first(where: {$0.name == "ground"})?.setState(bool: false)
            dontShowFlying = true
            customBools.bools.first(where: {$0.name == "flying"})?.setState(bool: false)
            dontShowFairy = true
            customBools.bools.first(where: {$0.name == "fairy"})?.setState(bool: false)
            dontShowOther = true
            customBools.bools.first(where: {$0.name == "other"})?.setState(bool: false)
        default:
            print("Wrong text input.")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
