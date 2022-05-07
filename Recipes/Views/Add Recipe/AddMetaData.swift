//
//  AddMetaData.swift
//  Recipes
//
//  Created by Kevin Tierney on 5/2/22.
//

import SwiftUI

struct AddMetaData: View {
    
    @Binding var name : String
    @Binding var summary : String
    @Binding var prepTime : String
    @Binding var cookTime : String
    @Binding var totalTime : String
    @Binding var servings : String
    var body: some View {
        Group{
            HStack{
                Text("Name: ")
                    .bold()
                TextField("Tuna caserole", text: $name)
            }
            
            HStack{
                Text("Summary: ")
                    .bold()
                TextField("A delicious meal for the family", text: $summary)
            }
            
            HStack{
                Text("Prep Time: ")
                    .bold()
                TextField("1 hour", text: $prepTime)
            }
            
            HStack{
                Text("Cook Time: ")
                    .bold()
                TextField("2 hour", text: $cookTime)
            }
            
            HStack{
                Text("Total Time: ")
                    .bold()
                TextField("3 hour", text: $totalTime)
            }
            
            HStack{
                Text("Servings: ")
                    .bold()
                TextField("6", text: $servings)
            }
        }
    }
}


