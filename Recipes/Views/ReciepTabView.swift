//
//  ReciepTabView.swift
//  Recipes
//
//  Created by Kevin Tierney on 3/7/22.
//

import SwiftUI

struct ReciepTabView: View {
    var body: some View {
        
        TabView{
            
            Text("Feautred View")
                .tabItem {
                    VStack{
                        Image(systemName: "star.fill")
                        Text("featured")
                    }
                }
            
            RecipeListView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
            
        }
    }
}

struct ReciepTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReciepTabView()
    }
}
