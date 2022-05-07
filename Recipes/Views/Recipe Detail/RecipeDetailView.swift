//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/28/22.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    @State var selectServingSize = 2
    
    var body: some View {
        ScrollView{
            
            VStack(alignment:.leading){
                
                // MARK: Recipe image
                let image = UIImage(data: recipe.image ?? Data()) ?? UIImage()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                
                Text(recipe.name)
                    .bold()
                    .padding(.top,20)
                    .padding(.leading)
                    .font(Font.custom("Avenir Heavy", size: 24))
                
                // MARK: Picker
                VStack(alignment: .leading){
                    
                    Text("Select your serving size:")
                        .font(Font.custom("Avenir", size: 15))
                    
                    Picker("", selection: $selectServingSize){
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .font(Font.custom("Avenir", size: 15))
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 160)
                    
                }
                .padding()
                
                // MARK: Ingredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .padding([.bottom,.top], 5)
                    
                    ForEach(recipe.ingredients.allObjects as! [Ingredient]) { item in
                        Text("• " + RecipeModel.getPortion(ingredient: item , recipeServings: recipe.servings, targetServings: selectServingSize) + " " + item.name.lowercased())
                            .font(Font.custom("Avenir", size: 15))
                    }
                }
                .padding(.horizontal)
              
                // MARK: Divider
                Divider()
                
                // MARK: Directions
                VStack(alignment:.leading){
                    
                    Text("Directions")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .padding([.bottom,.top], 5)
                    
                    ForEach(0..<recipe.directions.count, id:\.self){ index in
                        Text(String(index+1) + ". " + recipe.directions[index])
                            .padding(.bottom,5)
                            .font(Font.custom("Avenir", size: 15))
                    }
                }
                .padding(.horizontal)
            }
        }
        
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}