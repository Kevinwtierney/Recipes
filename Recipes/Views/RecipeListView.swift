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
            
            VStack(alignment: .leading){
                Text("All Recipes")
                    .bold()
                    .padding(.top,40)
                    .font(Font.custom("Avenir Heavy", size: 24))
                
                ScrollView{
                    
                    LazyVStack(alignment: .leading){
                        
                        ForEach(model.recipes) { r in
                            
                            NavigationLink(destination: RecipeDetailView(recipe:r)) {
                                HStack(spacing: 20.0){
                                    Image(r.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50,
                                               height: 50,
                                               alignment: .center)
                                        .clipped()
                                        .cornerRadius(5)
                                    VStack(alignment: .leading){
                                        Text(r.name)
                                            .foregroundColor(.black)
                                            .font(Font.custom("Avenir Heavy", size: 16))
                                        RecipeHighlightsView(highlights: r.highlights)
                                            .foregroundColor(.black)
                                    }
                            
                                }
                            }
                        }
                    }
                    
                }
                
            }
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
