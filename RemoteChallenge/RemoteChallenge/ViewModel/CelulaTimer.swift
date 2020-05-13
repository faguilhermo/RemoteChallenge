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
                Spacer()
            }
            HStack {
                Text("Passo único")
                Spacer()
            }
            HStack {
                Text("2:15:02")
                    .font(.system(size: 72))
                Spacer()
            }
        }
        .padding()
        .background(Color("mainColor"))
    }
}

struct CelulaTimer_Previews: PreviewProvider {
    static var previews: some View {
        CelulaTimer()
        .previewLayout(.fixed(width: 375, height: 144))
    }
}
