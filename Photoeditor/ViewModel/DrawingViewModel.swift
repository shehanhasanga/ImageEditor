//
//  DrawingViewModel.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import Foundation

class DrawingViewModel:ObservableObject{
    @Published var showImagePicker :Bool = false
    @Published var imageData :Data = Data(count: 0)
    
    func cancelEditing(){
        imageData = Data(count: 0)
    }
}
