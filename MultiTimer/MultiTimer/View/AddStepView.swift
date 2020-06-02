//
//  AddStepView.swift
//  MultiTimer
//
//  Created by Guilherme Enes on 02/06/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct AddStepView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    
    @State var hour: Int
    @State var minute: Int
    @State var second: Int
    
    var stepModel: (StepModel) -> ()
    
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
                    Text("Tempo da etapa")
                        .modifier(TextCustomModifier(fontType: .titleCell))
                        .padding(.top, 16)
                    TimerPicker(hour: $hour, minute: $minute, second: $second)
                    
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
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (_, _) in }
        })
    }
    
    private func saveButton() -> some View {
        return Button(action: {
            let totalInSeconds = TimeViewModel().totaInlSeconds(hour: self.hour, minute: self.minute, second: self.second)
            let treatedHours = TimeViewModel().secondsInHours(seconds: totalInSeconds)
            let treatedMinutes = TimeViewModel().secondsInMinutes(seconds: totalInSeconds)
            let treatedSeconds = TimeViewModel().seconds(totalInSeconds)
            let treatedTime = TimeViewModel().formatTime(hours: treatedHours, minutes: treatedMinutes, seconds: treatedSeconds)
            let treatedTitle = self.title == "" ? "Etapa" : self.title
            
            self.stepModel(.init(stepTitle: treatedTitle, stepTotalTime: totalInSeconds, stepShownTime: treatedTime))
            
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
