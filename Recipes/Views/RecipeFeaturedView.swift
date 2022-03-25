//
//  RecipeFeaturedView.swift
//  Recipes
//
//  Created by Kevin Tierney on 3/7/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    var body: some View {
        
        
        VStack(alignment:.leading, spacing: 0){
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top,40)
                .font(.largeTitle)
            
            GeometryReader{ geo in
                
                TabView(selection: $tabSelectionIndex){
                    
                    ForEach(0..<model.recipes.count){ index in
                        
                        if model.recipes[index].featured {
                            
                            // recipe card button
                            
                            Button ( action:{
                                self.isDetailViewShowing = true
                            }, label: {
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    VStack(spacing: 0){
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(5)
                                    }
                                }
                            })
                                .sheet(isPresented: $isDetailViewShowing) {
                                    RecipeDetailView(recipe: model.recipes[index])
                                    
                                }
                                .tag(index)
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: geo.size.width - 40 , height: geo.size.height - 100, alignment: .center)
                                .cornerRadius(15)
                                .shadow(color: Color(.sRGB, red: 0,green: 0,blue: 0, opacity: 0.6), radius: 10, x: -5, y: 5)
                            
                        }
                        
                    }
                    
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            
            
            
            VStack(alignment:.leading, spacing: 10){
                Text("Prep Time:")
                    .font(.headline)
                Text(model.recipes[tabSelectionIndex].prepTime)
                Text("Highlights:")
                    .font(.headline)
                RecipeHighlightsView(highlights: model.recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading,.bottom])
        }.onAppear {
            firstFeaturedIndex()
        }
        
    }
    
    func firstFeaturedIndex() {
        
        var index = model.recipes.firstIndex { (recipe) -> Bool in
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
