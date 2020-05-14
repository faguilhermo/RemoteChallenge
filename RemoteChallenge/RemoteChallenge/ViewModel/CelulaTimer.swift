//
//  CelulaTimer.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct CelulaTimer: View {
    
    var timerInfo: TimerModel
    
    var body: some View {

        ZStack {

            Color("mainColor")

            VStack {
                HStack {

                    Text("Timer")
                        .modifier(TextCustomView(defaultFont: .titleCell))

                    Spacer()

                    Text("04:20:30")
                        .modifier(TextCustomView(defaultFont: .totalTimerCell))

                }

                HStack {

                    Text("Passo único")
                        .modifier(TextCustomView(defaultFont: .subtitleCell))

                    Spacer()

                }

                HStack {

                    Text("2:15:02")
                        .modifier(TextCustomView(defaultFont: .stepTimerCell))

                    Spacer()

                }
            }
            .padding(.init(top: 12, leading: 20, bottom: 12, trailing: 20))

        }
    }
}

//struct CelulaTimer_Previews: PreviewProvider {
//    static var previews: some View {
//        CelulaTimer()
//            .previewLayout(.fixed(width: 375, height: 168))
//    }
//}
