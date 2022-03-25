//
//  RecipeModel.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/28/22.
//

import Foundation


class RecipeModel: ObservableObject{
    
    @Published var recipes = [Recipe]()
    
    init(){
        //create an instance of service and get the data
        self.recipes = DataService.getLocalData()
    }
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int)-> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            
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

            
        }
        
        
        return portion
        
    }
    
}
