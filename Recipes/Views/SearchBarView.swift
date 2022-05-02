//
//  SeacrhBarView.swift
//  Recipes
//
//  Created by Kevin Tierney on 5/2/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var filterBy: String
    @FocusState var isFocused: Bool
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 4)
            
            HStack{
                Image(systemName: "magnifyingglass")
                
                TextField("Filter by.....", text: $filterBy)
                    .focused($isFocused)
                
                Button{
                    
                    filterBy = ""
                    isFocused = false 
                    
                }label: {
                    
                    Image(systemName: "multiply.circle.fill")
                }
            }
            .padding()
        }
        .frame(height:48)
    }
}

