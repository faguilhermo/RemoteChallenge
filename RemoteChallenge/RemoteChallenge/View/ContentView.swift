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
                            CriarTimer()
                        }
                        .padding(.trailing)
                        .foregroundColor(Color("secondColor"))

                        Spacer()
                    }

                }

                HStack {

                    Text("Toque no \"+\" e adcione um timer")
                        .modifier(TextCustomView(defaultFont: .warningMessage))

                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
