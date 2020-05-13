//
//  ContentView.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingDetail = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    
                    self.showingDetail.toggle()
                }) {
                    Image(uiImage: #imageLiteral(resourceName: "add"))
                }
                .sheet(isPresented: $showingDetail) {
                    CriarTimer()
                }
                .padding(.trailing)
                .foregroundColor(Color("secondColor"))
            }
            Spacer()
            HStack {
                Text("Toque no '+' e adcione um timer")
                    .padding(.leading)
                    .padding(.bottom, 40)
                    .modifier(TextCustomView(fontSize: 48, fontStyle: "SFProDisplay-Light"))
                Spacer()
            }
            Spacer()
        }
        .background(Color("mainColor").edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
