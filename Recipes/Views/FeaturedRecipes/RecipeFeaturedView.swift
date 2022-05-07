//
//  RecipeFeaturedView.swift
//  Recipes
//
//  Created by Kevin Tierney on 3/7/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    //    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    
    @State var tabSelectionIndex = 0
    
    @FetchRequest( sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "featured == true"))
    var recipes: FetchedResults<Recipe>
    var body: some View {
        
        
        VStack(alignment:.leading, spacing: 0){
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top,40)
                .font(Font.custom("Avenir Heavy", size: 24))
            
            GeometryReader{ geo in
                
                TabView(selection: $tabSelectionIndex){
                    
                    ForEach(0..<recipes.count) { index in

                        // recipe card button
                        
                        Button ( action:{
                            self.isDetailViewShowing = true
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack(spacing: 0){
                                    let image = UIImage(data: recipes[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(recipes[index].name)
                                        .font(Font.custom("Avenir", size: 15))
                                        .padding(5)
                                }
                            }
                        })
                        .sheet(isPresented: $isDetailViewShowing) {
                            RecipeDetailView(recipe: recipes[index])
                            
                        }
                        .tag(index)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40 , height: geo.size.height - 100, alignment: .center)
                        .cornerRadius(15)
                        .shadow(color: Color(.sRGB, red: 0,green: 0,blue: 0, opacity: 0.6), radius: 10, x: -5, y: 5)
                        
                        
                        
                    }
                    
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            
            
            
            VStack(alignment:.leading, spacing: 10){
                Text("Prep Time:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                Text(recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir", size: 15))
                Text("Highlights:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlightsView(highlights: recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading,.bottom])
        }.onAppear {
            firstFeaturedIndex()
        }
        
    }
    
    func firstFeaturedIndex() {
        
        var index = recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        
        tabSelectionIndex = index ?? 0
        
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
