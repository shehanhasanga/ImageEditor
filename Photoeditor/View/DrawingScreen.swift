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
            GeometryReader{
                geometry -> AnyView in
                let size = geometry.frame(in: .global).size
                
                
                return AnyView(
                    ZStack{
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker,rect: size)
                    }
                    
                
                )
            }
          
        }
        .toolbar {
            ToolbarItem( placement: .navigationBarTrailing) {
                Button{
                    
                }label: {
                    Text("Save")
                }
                
            }
            ToolbarItem( placement: .navigationBarTrailing) {
                Button{
                    
                }label: {
                    Image(systemName: "plus")
                }
            }
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
    @Binding var toolPicker:PKToolPicker
    
    var rect: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = UIImage(data: imageData){
            let imageView = UIImageView(image: image)
            
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
            
            
        }
        
        
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
      
        
    }
}
