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
                Text("Clique no '+' e adcione um timer")
                    .font(.system(size: 48))
                    .fontWeight(.light)
                    .foregroundColor(Color("secondColor"))
                    .padding(.leading)
                    .padding(.bottom, 40)
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
