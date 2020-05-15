//
//  CelulaTimer.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct CelulaTimer: View {
    
    @State var timerInfo: TimerModel = TimerModel()
    
    var body: some View {

        ZStack {

            Color("mainColor")

            VStack {
                HStack {

                    Text(timerInfo.title)
                        .modifier(TextCustomView(defaultFont: .titleCell))

                    Spacer()

                    Text("\(timerInfo.totalHours):\(timerInfo.totalMinutes):\(timerInfo.totalSeconds)")
                        .modifier(TextCustomView(defaultFont: .totalTimerCell))

                }

                HStack {

                    Text(timerInfo.stepTitle)
                        .modifier(TextCustomView(defaultFont: .subtitleCell))

                    Spacer()

                }

                HStack {
                    //arrumar o timer dos passos!!
                    
                    Text("\(timerInfo.totalHours):\(timerInfo.totalMinutes):\(timerInfo.totalSeconds)")
                        .modifier(TextCustomView(defaultFont: .stepTimerCell))

                    Spacer()

                }
            }
            .padding(.init(top: 12, leading: 20, bottom: 12, trailing: 20))

        }
    }
    
    
//    func teste (Parametros: TimerModel) {
//        self.timerInfo = Parametros
//        print(timerInfo.title)
//    }
}

//struct CelulaTimer_Previews: PreviewProvider {
//    static var previews: some View {
//        CelulaTimer()
//            .previewLayout(.fixed(width: 375, height: 168))
//    }
//}
