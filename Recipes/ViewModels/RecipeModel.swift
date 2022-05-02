//
//  RecipeModel.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/28/22.
//

import Foundation
import UIKit


class RecipeModel: ObservableObject{
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    // reference to the managed object contex
    
    @Published var recipes = [Recipe]()
    
    init(){
       // check if we had preloaded the data
        checkLoadedData()
    }
    
    func checkLoadedData(){
        // check local storage for the flag
        
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
        
        // if it doesnt exist then parse local JSON and preload to core data
        
        if status == false {
            preloadLocalData()
            
        }
    }
    
    func preloadLocalData(){
        
        // parse local JSON file
       let localRecipes = DataService.getLocalData()
        // create core data objects
        
        for r in localRecipes {
            // create a core data object
            let recipe = Recipe(context: managedObjectContext)
            
            // set it properties
            
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.highlights = r.highlights
            recipe.id = UUID()
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.prepTime = r.prepTime
            recipe.name = r.name
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            // set ingredients
            
            for i in r.ingredients {
                // create core data ingredient object
                
                let ingredient = Ingredient(context: managedObjectContext)
                
                // set properties
                
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.unit = i.unit
                ingredient.denom = i.denom ?? 1
                ingredient.num = i.num ?? 1
                
                // add this ingredient to the recipe
                
                recipe.addToIngredients(ingredient)
                
            }
            
        }
        
        // save into core data
        do{
           try managedObjectContext.save()
            
            //set local storage flag
            
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        }
        catch{
            // couldnt sasve object
            print("error trying to save recipe Object to core data")
        }

    }
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int)-> String {
        
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholePortions = 0
        
        
        
        // get a single serving size  byn multiplying the denominater by the recipe servings
        
        denominator *= recipeServings
        
        // get target portion by multiplying numerator by tyarget portions
        
        numerator *= targetServings
        
        // reduce fraction by greatest common diviser
        
        let divisor = Rational.greatestCommonDivisor(numerator, denominator)
        numerator /= divisor
        denominator /= divisor
        
        // get the whole portion if numerator is > denominator
        
        if numerator >= denominator {
            
            // calculate whole portions
            wholePortions = numerator / denominator
            
            // calculate remainder
            numerator = numerator % denominator
            
            //assign to portion string
            portion += String(wholePortions)
            
        }
        
        // Express the remainder as a fraction
        if numerator > 0 {
            
            // assign remainder as fraction to portion string
            portion += wholePortions > 0 ? " " : ""
            portion += "\(numerator)/\(denominator)"
            
        }
        
        if var unit = ingredient.unit {
            
            if wholePortions > 1 {
                
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else{
                    unit += "s"
                }
                
                
            }
            
            //Calculate appropriate suffix
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portion + unit
        }
        
        return portion
        
    }
    
}
