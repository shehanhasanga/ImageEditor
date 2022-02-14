//
//  DrawingScreen.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    func getIndex(textBox:TextBox) -> Int{
        let index = model.textBoxes.firstIndex { box in
            return box.id == textBox.id
        } ?? 0
        return index
    }
    
    @EnvironmentObject var model : DrawingViewModel
    var body: some View {
        ZStack{
            GeometryReader{
                geometry -> AnyView in
                let size = geometry.frame(in: .global)
                DispatchQueue.main.async {
                    if model.rect == .zero {
                        model.rect = size
                    }
                    
                }
                
                return AnyView(
                    ZStack{
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker,rect: size.size)
                        
                        ForEach(model.textBoxes){
                            box in
                            Text(box.text)
                                .font(.system(size:35))
                                .fontWeight(box.isBool ? .bold : .none)
                                .foregroundColor(box.textColot)
                                .offset(box.offset)
                                .gesture(DragGesture().onChanged({ val in
                                    let current = val.translation
                                    let lastOffset = box.lastOffset
                                    let newTransplation = CGSize(width: lastOffset.width + current.width, height: lastOffset.height + current.height)
                                    model.textBoxes[getIndex(textBox: box)].offset = newTransplation
                                }).onEnded({ val in
                                    model.textBoxes[getIndex(textBox: box)].lastOffset = val.translation
                                })
                                )
                                .onLongPressGesture {
                                    model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                                    model.canvas.resignFirstResponder()
                                    model.currentIndex = getIndex(textBox: box)
                                    withAnimation {
                                        model.addNewBox = true
                                    }
                                }
                        }
                    }
                    
                
                )
            }
          
        }
        .toolbar {
            ToolbarItem( placement: .navigationBarTrailing) {
                Button{
                    model.saveImage()
                }label: {
                    Text("Save")
                }
                
            }
            ToolbarItem( placement: .navigationBarTrailing) {
                Button{
                    model.textBoxes.append(TextBox())
                    model.currentIndex = model.textBoxes.count - 1
                    withAnimation {
                        model.addNewBox.toggle()
                        model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                        model.canvas.resignFirstResponder()
                      
                    }
                   
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
