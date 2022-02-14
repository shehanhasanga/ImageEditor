//
//  TextBox.swift
//  Photoeditor
//
//  Created by shehan karunarathna on 2022-02-14.
//

import SwiftUI
import PencilKit

struct TextBox : Identifiable{
    var id: String  = UUID().uuidString
    var text: String = ""
    var isBool : Bool = false
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColot:Color = .white
    var isAdded:Bool = false
}
