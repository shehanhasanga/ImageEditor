//
//  DrawingViewModel.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import Foundation
import PencilKit
import SwiftUI

class DrawingViewModel:ObservableObject{
    @Published var showImagePicker :Bool = false
    @Published var imageData :Data = Data(count: 0)
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    
    @Published var textBoxes: [TextBox] = []
    @Published var addNewBox: Bool = false
    @Published var currentIndex: Int = 0
    
    @Published var rect: CGRect = .zero
    
    @Published var showAlert :Bool = false
    @Published var message :String = ""
    func cancelEditing(){
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }
    
    func cancelTextView(){
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        withAnimation {
           
            addNewBox = false
        }
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()
        }
        
     
    }
    
    func saveImage(){
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        let swiftView = ZStack{
            ForEach(textBoxes){
                box in
                Text(box.text)
                    .font(.system(size:35))
                    .fontWeight(box.isBool ? .bold : .none)
                    .foregroundColor(box.textColot)
                    .offset(box.offset)
            }
        }
        let controller  = UIHostingController(rootView: swiftView).view!
        controller.frame = rect
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        let generatedImage  = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = generatedImage?.pngData() {
            UIImageWriteToSavedPhotosAlbum(UIImage(data: image)! , nil, nil, nil)
            self.message = "Saved Successfully!!!"
            self.showAlert.toggle()
        }
    }
}
