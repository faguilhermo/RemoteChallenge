//
//  CriarTimer.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct CriarTimer: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var timerTitle: String = ""
    @State private var hourSelection = 0
    @State private var minuteSelection = 0
    @State private var secondSelection = 0

    @State private var repeatTimer = false
    @State private var favTimer = false
    @State private var stepTimer = false
    @State private var pauseBetweenSteps = false
    
    
    @State var timer = TimerModel()
    
    private let hours = [Int](0...24)
    private let minutes = [Int](0...60)
    private let seconds = [Int](0...60)

    var body: some View {
        ZStack {

            Color("mainColor")
                .edgesIgnoringSafeArea(.all)

            ScrollView {

                VStack(spacing: 0) {

                    HStack {

                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(uiImage: #imageLiteral(resourceName: "add"))
                                .foregroundColor(Color("secondColor"))
                                .rotationEffect(.degrees(45))
                        }

                    }

                    HStack {
                        Text("Nome (opcional)")
                            .modifier(TextCustomView(defaultFont: .titleCell))
                        Spacer()
                    }
                    .padding(.top, 16)

                    TextField("ex.: Molho pomodoro", text: $timerTitle)
                        .modifier(TextCustomView(defaultFont: .textField))

                    HStack {
                        Text("Tempo do timer")
                            .modifier(TextCustomView(defaultFont: .titleCell))
                        Spacer()
                    }
                    .padding(.top, 16)

                    HStack {

                        doPicker(selection: $hourSelection, array: hours, tempo: "horas")
                            .modifier(PickerCustomView())

                        doPicker(selection: $minuteSelection, array: minutes, tempo: "min")
                            .modifier(PickerCustomView())

                        doPicker(selection: $secondSelection, array: seconds, tempo: "seg")
                            .modifier(PickerCustomView())

                    }

                    HStack {

                        doToggle($repeatTimer, title: "Repetir timer")
                        Spacer()

                    }

                    HStack {

                        doToggle($favTimer, title: "Favoritar timer")
                        Spacer()

                    }

                    HStack {

                        doToggle($stepTimer, title: "Timer em etapas")
                            .onTapGesture {
                                print(self.stepTimer)
                                if self.stepTimer == true { self.pauseBetweenSteps = false }
                        }
                        Spacer()

                    }

                    HStack {
                        if self.stepTimer {
                            doToggle($pauseBetweenSteps, title: "Pausar entre etapas")
                            Spacer()
                        } else {
                            doToggle($pauseBetweenSteps, title: "Pausar entre etapas")
                                .disabled(true)
                            Spacer()
                        }

                    }
                }
            }
            .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))

            VStack {
                Spacer()
                if self.hourSelection == 0 && self.minuteSelection == 0 && self.secondSelection == 0 {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width-40, height: 67)
                            .cornerRadius(33.5)
                            .foregroundColor(Color("saveButtonColor"))
                        Text("Salvar")
                            .foregroundColor(Color("saveButtonTitleColor"))
                            .modifier(TextCustomView(defaultFont: .saveButton))
                    }
                    .opacity(0.80)
                    .disabled(true)
                } else {
                    Button(action: {
                        // TODO
                        self.saveTimer(title: self.timerTitle, totalHours: self.hourSelection, totalMinutes: self.minuteSelection, totalSeconds: self.secondSelection, isStepped: self.stepTimer, pauseBetweenSteps: self.pauseBetweenSteps, isFavorite: self.favTimer, repeatTimer: self.repeatTimer)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width-40, height: 67)
                                .cornerRadius(33.5)
                                .foregroundColor(Color("saveButtonColor"))
                            
                            Text("Salvar")
                                .foregroundColor(Color("saveButtonTitleColor"))
                                .modifier(TextCustomView(defaultFont: .saveButton))
                        }
                    
                    } 
                }
            }
            .padding(.bottom)
        }
    }

    func doPicker(selection: Binding<Int>, array: [Int], tempo: String) -> some View {
        let picker = Picker(selection: selection, label: Text("")) {
            ForEach(0..<array.count) { index in
                Text("\(array[index]) \(tempo)").tag(index)
                    .modifier(TextCustomView(defaultFont: .textField))
            }
        }
        return picker
    }

    func doToggle(_ isOn: Binding<Bool>, title: String) -> some View {
        let toggle = Toggle(isOn: isOn) {
            Text(title)
                .modifier(TextCustomView(defaultFont: .titleCell))
        }
        .padding(.top, 16)
        return toggle
    }

    func saveTimer(title: String, totalHours: Int, totalMinutes: Int, totalSeconds: Int, isStepped: Bool, pauseBetweenSteps: Bool, isFavorite: Bool, repeatTimer:Bool) {
        timer.title = title
        timer.totalHours = totalHours
        timer.totalMinutes = totalMinutes
        timer.totalSeconds = totalSeconds
        timer.isStepped = isStepped
        timer.pauseBetweenSteps = pauseBetweenSteps
        timer.isFavorite = isFavorite
        timer.repeatTimer = repeatTimer
    }
}

struct CriarTimer_Previews: PreviewProvider {
    static var previews: some View {
        CriarTimer()
    }
}
