//
//  StatsViewGroup.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-09.
//

import SwiftUI

struct StatsViewGroup: View {
    var pokemon: PokemonModel
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 300)
                .foregroundColor(.white)
                .opacity(0.8)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 30) {
                StatView(pokemon: pokemon, statName: "Atk", statColor: .red, statValue: pokemon.attack)
                StatView(pokemon: pokemon, statName: "Def", statColor: .green, statValue: pokemon.defense)
                StatView(pokemon: pokemon, statName: "Hgt", statColor: .orange, statValue: pokemon.height)
                StatView(pokemon: pokemon, statName: "Wgt", statColor: .yellow, statValue: pokemon.weight)
            }
        }
    }
}

struct StatsViewGroup_Previews: PreviewProvider {
    static var previews: some View {
        StatsViewGroup(pokemon: PokemonViewModel().SAMPLE_POKEMON)
    }
}
