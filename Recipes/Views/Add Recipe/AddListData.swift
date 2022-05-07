//
//  AddListData.swift
//  Recipes
//
//  Created by Kevin Tierney on 5/2/22.
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list: [String]
    var title: String
    var placeHolderText: String
    @State private var item: String = ""
    
    var body: some View {
        VStack(alignment:.leading){
            
            HStack{
                Text("\(title):")
                    .bold()
                TextField(placeHolderText, text: $item)
                
                Button("add"){
                    // Add item to list
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        list.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                        // Clear item after adding
                        item = ""
                    }
                }
            }
            
            // List items added so far
            
            ForEach(list, id: \.self) { item in
                Text(item)
            }
            
            
        }
    }
}

