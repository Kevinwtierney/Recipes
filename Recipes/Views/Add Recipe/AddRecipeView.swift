//
//  AddRecipeView.swift
//  Recipes
//
//  Created by Kevin Tierney on 5/2/22.
//

import SwiftUI

struct AddRecipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    //Properties for recipe meta data
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    @State private var servings = ""
    
    // Recipe IMage
    
    @State private var recipeImage : UIImage?
    
    // list type recipe meta data
    
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    // Ingrediaent data
    @State private var ingredients = [IngredientJSON]()
    
    @State private var isSHowingImagePicker = false
    @State var selectedImageSource : UIImagePickerController.SourceType
    @State var placeHolderImage = Image(systemName: "person.circle")
    
    @Binding var tabSelected:Int
    
    var body: some View {
        
        VStack{
            
            //Form Controls
            HStack{
                
                Button("Clear"){
                    // Clear the form
                    clear()
                }
                
                Spacer()
                
                Button("Add") {
                    // Add recipe to core data
                    addRecipe()
                    //Clear form
                    clear()
                    
                    // change to list view
                    tabSelected = 1
                }
                
            }
            
            ScrollView(showsIndicators: false){
                
                VStack{
                    
                    // Add placeholder Image
                    placeHolderImage
                        .resizable()
                        .scaledToFit()
                    
                    HStack{
                        
                        Button("Photo Library"){
                            selectedImageSource = .photoLibrary
                            isSHowingImagePicker = true
                            
                        }
                        
                        Text(" | ")
                        
                        Button("Camera"){
                            selectedImageSource = .camera
                            isSHowingImagePicker = true
                            
                        }
                    }
                    .sheet(isPresented: $isSHowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedSource: selectedImageSource, recipeImage: $recipeImage)
                    }
                }
                
                //                 the recipe meta data
                
                AddMetaData(name: $name,
                            summary: $summary,
                            prepTime: $prepTime,
                            cookTime: $cookTime,
                            totalTime: $totalTime,
                            servings: $servings)
                
                // list meta data
                AddListData(list: $highlights, title: "Highlights", placeHolderText: "Meat lover")
                AddListData(list: $directions, title: "Directions", placeHolderText: "Stir the sauce")
                
                // Add ingredient data
                AddIngredientData(ingredients: $ingredients)
                
            }
        }
        .padding()
    }
    
    func loadImage() {
        // check if an image was selected from the library
        if recipeImage != nil{
            // select it for the image
            placeHolderImage = Image(uiImage: recipeImage!)
        }
    }
    
    func clear(){
        
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        servings = ""
        highlights = [String]()
        directions = [String]()
        ingredients = [IngredientJSON]()
        placeHolderImage = Image(systemName: "person.circle")
    }
    
    func addRecipe(){
        
        let recipe = Recipe(context: viewContext)
        
        recipe.id = UUID()
        recipe.name = name
        recipe.cookTime = cookTime
        recipe.prepTime = prepTime
        recipe.totalTime = totalTime
        recipe.servings = Int(servings) ?? 1
        recipe.directions = directions
        recipe.highlights = highlights
        recipe.image = recipeImage?.pngData()
        
        // add ingredients
        for i in ingredients {
            let ingredient = Ingredient(context: viewContext)
            ingredient.id = UUID()
            ingredient.name = i.name
            ingredient.unit = i.unit
            ingredient.num = i.num ?? 1
            ingredient.denom = i.denom ?? 1
            
            // add this ingredient to the recipe
            recipe.addToIngredients(ingredient)
        }
        
        // save to core data
        do{
            try viewContext.save()
        }
        catch{
            print("Could not save recipe Try again later")
        }
       
        
    }
    
}



