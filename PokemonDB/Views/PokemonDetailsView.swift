//
//  PokemonDetailsView.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-09.
//

import SwiftUI

struct PokemonDetailsView: View {
    var pokemon: PokemonModel
    @State private var scale: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                
                Text(pokemon.type.capitalized)
                    .italic()
                    //.foregroundColor(pokemon.typeColor)
                
                PokemonImage(image: Image(pokemon.name))
                    .padding(.bottom, -100)
                    .zIndex(1)
                    .scaleEffect(scale)
                    .onAppear {
                        let baseAnimation = Animation.spring( dampingFraction: 0.5)
                        let repeated = baseAnimation.repeatCount(1)
                        
                        withAnimation(repeated) {
                            scale = 1
                        }
                    }
                
                ZStack {
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(pokemon.typeColor)
                    
                    VStack {
                        if pokemon.isFav {
                            //SF Symbols app för att hitta system images
                            Label("Favorite", systemImage: "star.fill")
                                .foregroundColor(pokemon.typeColor)
                                .padding(15)
                                .background(Capsule())
                                .foregroundColor(.white)
                        }
                        
                        Text(pokemon.description.replacingOccurrences(of: "\n", with: ""))
                            .foregroundColor(.white)
                            .padding()
                        
                        StatsViewGroup(pokemon: pokemon)
                    }
                    .offset(y: -40)
                    .transition(.slide)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: PokemonViewModel().SAMPLE_POKEMON)
    }
}
