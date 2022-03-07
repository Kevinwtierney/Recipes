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
    
}
