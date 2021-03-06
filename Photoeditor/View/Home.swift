//
//  Home.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = DrawingViewModel()
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    
                    if let _image = UIImage(data: viewModel.imageData){
                       DrawingScreen()
                            .environmentObject(viewModel)
                            .toolbar {
                                ToolbarItem( placement: .navigationBarLeading) {
                                    Button{
                                        viewModel.cancelEditing()
                                    }label: {
                                       Image(systemName: "xmark")
                                        
                                    }
                                }
                                
                            }
                        
                    } else{
                        Button{
                            viewModel.showImagePicker.toggle()
                            
                        }label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 70, height: 70)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.6), radius: 10, x: 0, y: 0)
                        }
                    }
                    
                }.navigationTitle("Image Editor")
            }
            if viewModel.addNewBox {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                TextField("Type Here..",text: $viewModel.textBoxes[viewModel.currentIndex].text)
                    .font(.system(size: 35,weight :
                            viewModel.textBoxes[viewModel.currentIndex].isBool ?  .bold : .regular)
                    )
                    .colorScheme(.dark)
                    .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColot)
                    .padding()
                
                
                HStack{
                    Button{
                        viewModel.textBoxes[viewModel.currentIndex].isAdded = true
                        viewModel.toolPicker.setVisible(true, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.becomeFirstResponder()
                        withAnimation {
                            viewModel.addNewBox = false
                            
                        }
                    }label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    Button{
                        viewModel.cancelTextView()
                    }label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .overlay(
                    HStack(spacing:15){
                        ColorPicker("", selection: $viewModel.textBoxes[viewModel.currentIndex].textColot)
                            .labelsHidden()
                        Button{
                            viewModel.textBoxes[viewModel.currentIndex].isBool.toggle()
                        }label: {
                            Text(viewModel.textBoxes[viewModel.currentIndex].isBool ? "Normal" : "Bold")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    
                )
                .frame(maxHeight:.infinity, alignment: .top)
            }
           
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(showPicker: $viewModel.showImagePicker, imageData: $viewModel.imageData)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Message"), message: Text(viewModel.message) , dismissButton: .destructive(Text("Ok")))
        }
       
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
