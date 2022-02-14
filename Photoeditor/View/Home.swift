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
        NavigationView{
            VStack{
                
                if let image = UIImage(data: viewModel.imageData){
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
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(showPicker: $viewModel.showImagePicker, imageData: $viewModel.imageData)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
