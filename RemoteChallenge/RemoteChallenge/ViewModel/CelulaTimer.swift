//
//  CelulaTimer.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct CelulaTimer: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Timer")
                    .modifier(TextCustomView())
                Spacer()
                Text("04:20:30")
                    .modifier(TextCustomView(fontSize: 22))
            }
            
            HStack {
                Text("Passo único")
                Spacer()
            }
            .modifier(TextCustomView(fontSize: 24, fontStyle: "SFProDisplay-Semibold"))
            
            HStack {
                Text("2:15:02")
                Spacer()
            }
            .modifier(TextCustomView(fontSize: 72, fontStyle: "SFProDisplay-Bold"))
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(Color("mainColor"))
        
    }
}

struct CelulaTimer_Previews: PreviewProvider {
    static var previews: some View {
        CelulaTimer()
            .previewLayout(.fixed(width: 375, height: 144))
    }
}
