//
//  ReciepTabView.swift
//  Recipes
//
//  Created by Kevin Tierney on 3/7/22.
//

import SwiftUI

struct ReciepTabView: View {
    
    @State var tabSelected = 0
    var body: some View {
        
        TabView(selection: $tabSelected){
            
            RecipeFeaturedView()
                .tabItem {
                    VStack{
                        Image(systemName: "star.fill")
                        Text("featured")
                    }
                }.tag(0)
            
            RecipeListView()
                .tabItem {
                    
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }.tag(1)
            
            AddRecipeView(selectedImageSource: .photoLibrary, tabSelected: $tabSelected)
                .tabItem {
                    
                    VStack{
                        Image(systemName: "plus.circle")
                        Text("Add")
                    }
                }.tag(2)
            
        }
        .environmentObject(RecipeModel())
    }
}

struct ReciepTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReciepTabView()
    }
}
