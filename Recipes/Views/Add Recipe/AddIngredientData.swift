//
//  AddIngredientData.swift
//  Recipes
//
//  Created by Kevin Tierney on 5/2/22.
//

import SwiftUI

struct AddIngredientData: View {
    
    @Binding var ingredients: [IngredientJSON]
    
    @State private var name = ""
    @State private var unit = ""
    @State private var num = ""
    @State private var denom = ""
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Ingredients: ")
                .bold()
            
            HStack{
                
                TextField("sugar", text: $name)
                
                TextField("1", text: $num)
                    .frame(width:20)
                
                Text("/")
                
                TextField("2", text: $denom)
                    .frame(width:20)
                
                TextField("cups", text: $unit)

                Button("add") {
                    
                    // clean input strings
                    let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedUnit = unit.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedNum = num.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedDenom = denom.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if cleanedNum == "" || cleanedName == "" || cleanedUnit == "" || cleanedDenom == "" {
                        return
                    }
                    
                    // create the ingredientJSON object and set properties
                    
                    let i = IngredientJSON()
                    i.id = UUID()
                    i.name = cleanedName
                    i.unit = cleanedUnit
                    i.num = Int(cleanedNum) ?? 1
                    i.denom = Int(cleanedDenom) ?? 1
                    
                    // Add this ingredient to the list
                    ingredients.append(i)
                    
                    // Clear data
                    name = ""
                    unit = ""
                    num = ""
                    denom = ""
                }
            }
            
            ForEach(ingredients) {ingredient in
                Text("\(ingredient.name), \(ingredient.num ?? 1)/\(ingredient.denom ?? 1)\(ingredient.unit ?? "")")
            }
        }
    }
}


