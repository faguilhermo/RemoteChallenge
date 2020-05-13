//
//  TextCustomView.swift
//  RemoteChallenge
//
//  Created by Guilherme Enes on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct TextCustomView: ViewModifier {
    @State  var fontSize: CGFloat = 24
    @State  var fontStyle: String = "SFProDisplay-Light"
    
    
    func body(content: Content) -> some View {
        
        return content
            .foregroundColor(Color("secondColor"))
            .font(.custom(fontStyle, size: fontSize))
    }
}

