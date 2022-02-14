//
//  DrawingScreen.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var model : DrawingViewModel
    var body: some View {
        ZStack{
            CanvasView(canvas: $model.canvas, imageData: $model.imageData)
        }
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CanvasView: UIViewRepresentable{
    @Binding var canvas: PKCanvasView
    @Binding var imageData:Data
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        if let image = UIImage(data: imageData){
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
        }
        
    }
}
