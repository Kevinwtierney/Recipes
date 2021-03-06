//
//  ContentView.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/25/22.
//

import SwiftUI

struct RecipeListView: View {
    

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors:[NSSortDescriptor(key: "name", ascending: true)])
    private var recipes: FetchedResults<Recipe>
    
    @State private var filterBy = ""
    
    private var filteredRecipes: [Recipe] {
        if filterBy.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return Array(recipes)
        }
        else{
            // filter results by search term
            return recipes.filter { r in
               return  r.name.contains(filterBy)
            }
        }
            
    }
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading){
                
                Text("All Recipes")
                    .bold()
                    .padding(.top,40)
                    .font(Font.custom("Avenir Heavy", size: 24))
                
                SearchBarView(filterBy: $filterBy)
                    .padding([.trailing,.bottom])
                
                ScrollView{
                    
                    LazyVStack(alignment: .leading){
                        
                        ForEach(filteredRecipes) { r in
                            
                            NavigationLink(destination: RecipeDetailView(recipe:r)) {
                                HStack(spacing: 20.0){
                                    let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
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
            .onTapGesture {
                // resign first responder
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()

    }
}
