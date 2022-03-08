//
//  ContentView.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/25/22.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model:RecipeModel

    var body: some View {
        
        NavigationView {
            List(model.recipes) { r in
                
                NavigationLink(destination: RecipeDetailView(recipe:r)) {
                    HStack(spacing: 20.0){
                        Image(r.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,
                                   height: 50,
                                   alignment: .center)
                            .clipped()
                            .cornerRadius(5)
                        Text(r.name)
                    }
                }
                
            }
            .navigationBarTitle("All Recipes")
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
