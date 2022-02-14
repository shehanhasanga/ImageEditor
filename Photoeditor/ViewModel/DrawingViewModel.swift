//
//  DrawingViewModel.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import Foundation
import PencilKit

class DrawingViewModel:ObservableObject{
    @Published var showImagePicker :Bool = false
    @Published var imageData :Data = Data(count: 0)
    
    @Published var canvas = PKCanvasView()
    
    func cancelEditing(){
        imageData = Data(count: 0)
    }
}
