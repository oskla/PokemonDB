//
//  PokemonImage.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-09.
//

import Foundation
import SwiftUI

struct PokemonImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(Color.white, lineWidth: 5))
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.white))
            .shadow(radius: 5)
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(image: Image(PokemonViewModel().SAMPLE_POKEMON.name))
    }
}
