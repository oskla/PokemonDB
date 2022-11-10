//
//  Toggle.swift
//  PokemonDB
//
//  Created by Fredrik Kypta on 2022-11-10.
//

import SwiftUI

struct ToggleButton: View {
    var onColor: Color
    @State var isOn: Bool
    var type: String
    var function: () -> Void
    
    @EnvironmentObject var customBools: CustomBools
    
        
    var body: some View {
        let customBool = customBools.bools.first(where: {$0.name == "fire"})?.state

        VStack {
            if customBool! {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(onColor)
                    .frame(width: 70, height: 20)
                    Text("\(customBools.bools.count)").font(.system(.body).bold()).foregroundColor(.white)
                }
                Button {
                    let customBool = CustomBool(state: true, name: "Test")
                    customBools.bools.append(customBool)
                } label: {
                    Label("Add",systemImage: "plus")
                }
                Text("")
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(onColor)
                        .frame(width: 70, height: 20)
                    .opacity(0.2)
                    Text(type).font(.system(.body)).foregroundColor(.gray)
                }
            }
        }
        .onTapGesture {
            function()
            //isOn.toggle()
            let customBool = customBools.bools.first(where: {$0.name == "fire"})
            customBool!.toggle()
        }
        
    }

    
}

struct Toggle_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButton(onColor: .blue, isOn: true, type: "Poison", function: {})
    }
}
