//
//  ImagePicker.swift
//  Recipes
//
//  Created by Kevin Tierney on 5/2/22.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
     var selectedSource : UIViewControllerType.SourceType
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var recipeImage : UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // create UI Image picker controller
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        
        // Check that image source is available
        
        if UIImagePickerController.isSourceTypeAvailable(selectedSource){
            imagePicker.sourceType = selectedSource
        }
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent:ImagePicker
        
        init(parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // check if we can get the image
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                parent.recipeImage = image
            }
            
            // Dismiss this view
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}
