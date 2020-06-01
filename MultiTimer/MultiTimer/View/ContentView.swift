//
//  ContentView.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 18/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var timers: [TimerModel] = []
    @State var isAddNewTimerPresented = false
    @State private var selection: Set<TimerModel> = []

    var body: some View {
        ZStack {
            Color("Main-Color")
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .trailing) {

                Button(action: {
                    self.isAddNewTimerPresented.toggle()
                }) {
                    Image(uiImage: #imageLiteral(resourceName: "add"))
                        .foregroundColor(Color("Secondary-Color"))
                        .padding([.trailing, .top])
                }.sheet(isPresented: $isAddNewTimerPresented, content: {
                    AddNewTimerView(hour: 0, minute: 0, second: 0, addTimer: { timer in
                        self.timers.append(timer)
                    })
                })

                List {
                    ForEach(timers, id: \.id) { timer in
                        ListCell(isExpended: self.selection.contains(timer), timer: timer, didDelete: { _ in
                            self.timers.removeAll(where: {$0.id == timer.id})
                        }, totalTime: timer.totalTime, repeatTimer: timer.repeatTimer)
                            .onTapGesture { self.selectDeselect(timer) }
                    }
                }
            }

            if timers.count == 0 {
                Text("Toque no \"+\" e adicione um novo timer")
                    .modifier(TextCustomModifier(fontType: .addNewTimerMessage))
            }
        }
    }

    private func selectDeselect(_ timer: TimerModel) {
        if selection.contains(timer) {
            selection.remove(timer)
        } else {
            selection.insert(timer)
        }
    }
}
