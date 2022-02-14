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
    
    func cancelEditing(){
        imageData = Data(count: 0)
        canvas = PKCanvasView()
    }
    
    func cancelTextView(){
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        withAnimation {
           
            addNewBox = false
        }
        textBoxes.removeLast()
    }
}
