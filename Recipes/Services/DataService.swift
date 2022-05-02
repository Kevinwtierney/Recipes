//
//  DataService.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/28/22.
//

import Foundation

class DataService {
    
   static func getLocalData() -> [RecipeJSON] {
        
        // parse local Json data
        
        // get url path to json data
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // check if pathString data is not nil
        guard pathString != nil else {
            return [RecipeJSON]()
        }
        
        //create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // create a data object
            let data = try Data(contentsOf: url)
            
            //decode data from data object with Json Decoder
            let decoder = JSONDecoder()
            
            do {
                let recipeData = try decoder.decode([RecipeJSON].self, from: data)
                
                // add the UUID's
                
                for r in recipeData{
                    r.id = UUID()
                    
                    for i in r.ingredients{
                        i.id = UUID()
                    }
                }
                
                // return the recipes
                return recipeData
            }
            catch {
                print(error)
            }
            
        }
        catch {
            print(error)
        }
        return[RecipeJSON]()
    }
    
   
}
