//
//  ImagePicker.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var showPicker:Bool
    @Binding var imageData:Data
    func makeUIViewController(context: Context) ->  UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
       
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent:ImagePicker
        
        init(parent:ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let imageDats = (info[.originalImage] as? UIImage)?.pngData(){
                parent.imageData = imageDats
                parent.showPicker.toggle()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.showPicker.toggle()
        }
    }
    
    
}
