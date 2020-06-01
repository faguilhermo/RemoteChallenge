//
//  AddNewTimerView.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 18/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct AddNewTimerView: View {

    @Environment(\.presentationMode) var presentationMode

    @State var title: String = ""
    @State var subtitle: String = ""

    @State var hour: Int
    @State var minute: Int
    @State var second: Int

    @State var repeatTimer: Bool = false
    @State var timesToRepeat: Int = 0

    var addTimer: (TimerModel) -> ()
    var id = Int.random(in: 0...100000)

    private let numbersToRepeat = [Int](2...100)

    var body: some View {
        ZStack {
            Color("Main-Color")
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.endEditing()
            }

            VStack (alignment: .leading, spacing: 0) {
                Group {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(uiImage: #imageLiteral(resourceName: "add"))
                                .foregroundColor(Color("Secondary-Color"))
                                .rotationEffect(.degrees(45))
                        }
                    }

                    Text("Nome (opcional)")
                        .modifier(TextCustomModifier(fontType: .titleCell))
                        .padding(.top)
                    TextField("Titulo", text: $title)
                        .modifier(TextCustomModifier(fontType: .textField))
                    Text("Subtítulo (opcional)")
                        .modifier(TextCustomModifier(fontType: .titleCell))
                        .padding(.top, 16)
                    TextField("Subtitulo", text: $subtitle) 
                        .modifier(TextCustomModifier(fontType: .textField))
                    Text("Tempo do timer")
                        .modifier(TextCustomModifier(fontType: .titleCell))
                        .padding(.top, 16)
                    TimerPicker(hour: $hour, minute: $minute, second: $second)

                    doToggle($repeatTimer, title: "Repetir timer")
                    if self.repeatTimer {
                        Picker(selection: $timesToRepeat, label: Text("")) {
                            ForEach(0..<numbersToRepeat.count) { index in
                                Text("\(self.numbersToRepeat[index])").tag(index)
                            }
                        }
                        .labelsHidden()
                        .frame(width: UIScreen.main.bounds.width-40, height: 100)
                        .clipped()
                    }
                }

                Spacer()

                HStack {
                    if self.hour == 0 && self.minute == 0 && self.second == 0 {
                        VStack (alignment: .leading) {
                            Text("Coloque um timer maior que 0 segundos")
                                .font(.custom("SFProDisplay-Ultralight", size: 16))
                                .padding(.leading, 33)
                                .opacity(0.7)
                            saveButton()
                                .opacity(0.85)
                                .disabled(true)
                        }
                    } else {
                        saveButton()
                    }
                }
            }.padding()
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (_, _) in
            }
        })
    }

    private func doToggle(_ isOn: Binding<Bool>, title: String) -> some View {
        let toggle = Toggle(isOn: isOn) {
            Text(title)
                .modifier(TextCustomModifier(fontType: .titleCell))
        }
        return toggle
            .padding(.trailing, 2)
            .padding(.top, 16)
    }

    private func saveButton() -> some View {
        return Button(action: {
            let totalInSeconds = TimeViewModel().totaInlSeconds(hour: self.hour, minute: self.minute, second: self.second)
            let treatedHours = TimeViewModel().secondsInHours(seconds: totalInSeconds)
            let treatedMinutes = TimeViewModel().secondsInMinutes(seconds: totalInSeconds)
            let treatedSeconds = TimeViewModel().seconds(totalInSeconds)
            let treatedTime = TimeViewModel().formatTime(hours: treatedHours, minutes: treatedMinutes, seconds: treatedSeconds)
            let treatedTitle = self.title == "" ? "Timer" : self.title
            let treatedSubtitle = self.subtitle == "" ? "Passo único" : self.subtitle
            self.addTimer(.init(id: self.id, title: treatedTitle, subtitle: treatedSubtitle, timer: treatedTime,  totalTime: totalInSeconds, repeatTimer: self.repeatTimer, repetitionNumber: self.timesToRepeat+2))
            self.presentationMode.wrappedValue.dismiss()
        }) {
            ZStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width-40, height: 67)
                    .foregroundColor(Color("Save-Button-Background-Color"))
                    .cornerRadius(60)
                Text("Salvar")
                    .modifier(TextCustomModifier(fontType: .saveButton))
            }
        }
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }

}
