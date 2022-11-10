//
//  CustomBool.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-10.
//

import SwiftUI

class CustomBool: Identifiable {
    var state: Bool
    var name: String
    
    init(state: Bool, name: String) {
        self.state = state
        self.name = name
    }
    
    func toggle() {
        state = !state
    }
    
    func setState(bool: Bool) {
        state = bool
    }
}

@MainActor class CustomBools: ObservableObject {
    @Published var bools: [CustomBool]
    
    init(bools: [CustomBool]) {
        self.bools = bools
    }
}
