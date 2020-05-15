//
//  ContentView.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var addTimer = false
    
    @State var timer: TimerModel

    

    var body: some View {
        VStack {
            ZStack {

                Color("mainColor")
                    .edgesIgnoringSafeArea(.all)
                
                HStack {

                    Spacer()

                    VStack {

                        Button(action: {
                            self.addTimer.toggle()
                        }) {
                            Image(uiImage: #imageLiteral(resourceName: "add"))
                        }
                        .sheet(isPresented: $addTimer) {
                            CriarTimer(timer: self.$timer)
                        }
                        .padding(.trailing)
                        .foregroundColor(Color("secondColor"))

                        Spacer()
                    }

                }
        
                 .padding(.init(top: 50, leading: 20, bottom: 20, trailing: 20))
                
                
                HStack {
//                    Text("Toque no \"+\" para adicionar um timer.")
//                        .modifier(TextCustomView(defaultFont: .warningMessage))
                    CelulaTimer(timerInfo: timer)
                        .frame(height: 168)

                    Spacer()
                }
                .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
